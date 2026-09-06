-- Keep Gin's buffers alive: its asynchronous refreshes retain their IDs.
local M = {}
local views = {}

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

function M.open(kind)
  local status = vim.api.nvim_get_current_win()
  if vim.api.nvim_win_get_config(status).relative == '' then
    vim.notify('Open GinStatus with GinFloat to use the preview', vim.log.levels.INFO)
    return
  end
  local line = vim.api.nvim_get_current_line()
  if line:sub(1, 1) == '#' or #line < 4 then return end
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
      -- Check the window ID: an untracked file may also be open for editing.
      if not untracked then vim.keymap.set('n', 'q', function()
        if vim.api.nvim_get_current_win() == view.preview then close(status) end
      end, { buffer = result, silent = true, desc = 'Close Gin preview' }) end
    end
  end
end

function M.setup(buf)
  vim.keymap.set('n', 'p', function() M.open() end, { buffer = buf, nowait = true, desc = 'Preview diff below' })
  vim.keymap.set('n', 'gS', function() M.open('cached') end, { buffer = buf, desc = 'Preview staged diff' })
  vim.keymap.set('n', 'gU', function() M.open('local') end, { buffer = buf, desc = 'Preview unstaged diff' })
  vim.keymap.set('n', '<Tab>', function()
    local view = views[vim.api.nvim_get_current_win()]
    if view and valid(view.preview) then vim.api.nvim_set_current_win(view.preview) end
  end, { buffer = buf, desc = 'Focus Gin preview' })
end

return M
