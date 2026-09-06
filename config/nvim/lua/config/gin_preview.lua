-- Keep Gin's buffers alive: its asynchronous refreshes retain their IDs.
local M = {}
local views = {}
local updating = false
local line_numbers = vim.api.nvim_create_namespace('GinPreviewLineNumbers')

-- Decorate the unified diff without changing the text Gin parses for jumps.
local function show_source_lines(buf)
  vim.api.nvim_buf_clear_namespace(buf, line_numbers, 0, -1)
  local old, new, old_left, new_left
  for i, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
    local a, ac, b, bc = line:match('^@@ %-(%d+)(,?%d*) %+(%d+)(,?%d*) @@')
    if a then
      old, new = tonumber(a), tonumber(b)
      old_left = ac == '' and 1 or tonumber(ac:sub(2))
      new_left = bc == '' and 1 or tonumber(bc:sub(2))
    elseif old and (old_left > 0 or new_left > 0) then
      local prefix = line:sub(1, 1)
      local left, right = '', ''
      if prefix == '-' and old_left > 0 then
        left, old, old_left = tostring(old), old + 1, old_left - 1
      elseif prefix == '+' and new_left > 0 then
        right, new, new_left = tostring(new), new + 1, new_left - 1
      elseif prefix == ' ' and old_left > 0 and new_left > 0 then
        left, right = tostring(old), tostring(new)
        old, new, old_left, new_left = old + 1, new + 1, old_left - 1, new_left - 1
      end
      if left ~= '' or right ~= '' then
        vim.api.nvim_buf_set_extmark(buf, line_numbers, i - 1, 0, {
          virt_text = { { string.format('%4s %4s │ ', left, right), 'LineNr' } },
          virt_text_pos = 'inline',
        })
      end
    end
  end
end

local function valid(win)
  return win and vim.api.nvim_win_is_valid(win)
end

local function close(status)
  local view = views[status]
  if not view then return end
  views[status] = nil
  vim.api.nvim_del_augroup_by_id(view.group)
  if valid(view.preview) then vim.api.nvim_win_close(view.preview, false) end
  if valid(status) then
    vim.api.nvim_win_set_config(status, view.original)
    vim.api.nvim_set_current_win(status)
  end
end

local function layout(status, view)
  local width = math.max(1, math.floor(vim.o.columns * 0.85))
  local total = math.max(6, math.floor((vim.o.lines - vim.o.cmdheight) * 0.85))
  local top = math.max(2, math.floor((total - 4) * 0.3))
  local row = math.max(0, math.floor((vim.o.lines - vim.o.cmdheight - total) / 2))
  local col = math.floor((vim.o.columns - width) / 2)
  vim.api.nvim_win_set_config(status, {
    relative = 'editor', row = row, col = col, width = width, height = top,
  })
  vim.api.nvim_win_set_config(view.preview, {
    relative = 'editor', row = row + top + 2, col = col,
    width = width, height = math.max(1, total - top - 4),
  })
end

local function open(kind)
  local status = vim.api.nvim_get_current_win()
  if vim.api.nvim_win_get_config(status).relative == '' then
    vim.notify('Open GinStatus with GinFloat to use the preview', vim.log.levels.INFO)
    return
  end
  local line = vim.api.nvim_get_current_line()
  local is_file = line:sub(1, 1) ~= '#' and #line >= 4
  local untracked = line:sub(1, 2) == '??'
  local action = untracked and 'edit:local:edit' or ('diff:' .. (kind or 'smart') .. ':edit')
  local buf = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(status)
  local view = views[status]
  if not view then
    view = { original = vim.api.nvim_win_get_config(status) }
    views[status] = view
    view.preview = vim.api.nvim_open_win(buf, false, {
      relative = 'editor', row = 0, col = 0, width = 1, height = 1,
      style = 'minimal', border = 'rounded',
    })
    view.group = vim.api.nvim_create_augroup('GinPreview' .. status, { clear = true })
    vim.api.nvim_create_autocmd('WinClosed', {
      group = view.group, pattern = { tostring(status), tostring(view.preview) },
      callback = function() vim.schedule(function() close(status) end) end,
    })
    vim.api.nvim_create_autocmd('VimResized', {
      group = view.group,
      callback = function()
        if valid(status) and valid(view.preview) then layout(status, view) end
      end,
    })
  end
  layout(status, view)
  if not is_file then
    if not view.empty or not vim.api.nvim_buf_is_valid(view.empty) then
      view.empty = vim.api.nvim_create_buf(false, true)
      vim.bo[view.empty].bufhidden = 'wipe'
      vim.api.nvim_buf_set_lines(view.empty, 0, -1, false, { 'Select a file to preview its diff.' })
    end
    vim.api.nvim_win_set_buf(view.preview, view.empty)
    vim.api.nvim_win_set_config(view.preview, { title = ' Diff ', title_pos = 'center' })
    return
  end
  -- Run Gin's own candidate parser with the status buffer/cursor in the lower
  -- window. Its edit opener replaces that window only (also handles renames).
  vim.api.nvim_set_current_win(view.preview)
  vim.api.nvim_win_set_buf(view.preview, buf)
  vim.api.nvim_win_set_cursor(view.preview, cursor)
  local ok, err = pcall(vim.fn['denops#request'], 'gin', 'action:action:' .. action, { buf })
  if valid(status) then vim.api.nvim_set_current_win(status) end
  if not ok then
    close(status)
    vim.notify(tostring(err), vim.log.levels.ERROR)
    return
  end
  if valid(view.preview) then
    local result = vim.api.nvim_win_get_buf(view.preview)
    if result ~= buf then
      vim.api.nvim_win_set_config(view.preview, {
        title = untracked and ' New file (content) ' or ' Diff (unified) ', title_pos = 'center',
      })
      vim.wo[view.preview].number = untracked
      vim.wo[view.preview].relativenumber = false
      if not untracked then show_source_lines(result) end
      -- Check the window ID: an untracked file may also be open for editing.
      if not untracked then vim.keymap.set('n', 'q', function()
        if vim.api.nvim_get_current_win() == view.preview then close(status) end
      end, { buffer = result, silent = true, desc = 'Close Gin preview' }) end
    end
  end
end

function M.open(kind)
  if updating then return end
  updating = true
  local ok, err = pcall(open, kind)
  updating = false
  if not ok then vim.notify(tostring(err), vim.log.levels.ERROR) end
end

function M.edit_file()
  if updating then return end
  local status = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(status)
  local line = vim.api.nvim_get_current_line()
  if line:sub(1, 1) == '#' or #line < 4 then return end
  local floating = vim.api.nvim_win_get_config(status).relative ~= ''
  local target = floating and vim.w[status].gin_origin_win or status
  if not valid(target) or vim.api.nvim_win_get_config(target).relative ~= '' then
    target = nil
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(win).relative == '' then target = win; break end
    end
  end
  if not target then return end
  updating = true
  -- Let Gin resolve the selected path first, then display the resulting file
  -- in the original editing window. No status-line parsing or register edits.
  local ok, err = pcall(function()
    vim.fn['denops#request']('gin', 'action:action:edit:local:edit', { buf })
    local file = vim.api.nvim_get_current_buf()
    if file == buf then return end
    if floating then
      vim.api.nvim_win_set_buf(target, file)
      close(status)
      if valid(status) then vim.api.nvim_win_close(status, false) end
      vim.api.nvim_set_current_win(target)
    end
  end)
  if not ok and valid(status) then
    vim.api.nvim_win_set_buf(status, buf)
    vim.api.nvim_win_set_cursor(status, cursor)
    vim.api.nvim_set_current_win(status)
  end
  updating = false
  if not ok then vim.notify(tostring(err), vim.log.levels.ERROR) end
end

function M.setup(buf)
  vim.keymap.set('n', '<CR>', M.edit_file, { buffer = buf, silent = true, desc = 'Open file in editing window' })
  local group = vim.api.nvim_create_augroup('GinAutoPreview' .. buf, { clear = true })
  local generation = 0
  local function queue()
    if updating then return end
    local win = vim.api.nvim_get_current_win()
    -- The preview temporarily displays the status buffer while Gin resolves
    -- the selected file; never treat that lower window as a new status view.
    for _, view in pairs(views) do
      if view.preview == win then return end
    end
    if vim.api.nvim_get_current_buf() ~= buf or vim.api.nvim_win_get_config(win).relative == '' then return end
    generation = generation + 1
    local ticket = generation
    vim.defer_fn(function()
      if ticket ~= generation or updating or not valid(win) then return end
      if vim.api.nvim_get_current_win() ~= win or vim.api.nvim_win_get_buf(win) ~= buf then return end
      M.open()
    end, 120)
  end
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'BufWinEnter', 'TextChanged' }, {
    group = group, buffer = buf, callback = queue,
  })
  queue()
  vim.keymap.set('n', 'p', function() M.open() end, { buffer = buf, nowait = true, desc = 'Preview diff below' })
  vim.keymap.set('n', 'gS', function() M.open('cached') end, { buffer = buf, desc = 'Preview staged diff' })
  vim.keymap.set('n', 'gU', function() M.open('local') end, { buffer = buf, desc = 'Preview unstaged diff' })
  vim.keymap.set('n', '<Tab>', function()
    local view = views[vim.api.nvim_get_current_win()]
    if view and valid(view.preview) then vim.api.nvim_set_current_win(view.preview) end
  end, { buffer = buf, desc = 'Focus Gin preview' })
end

return M
