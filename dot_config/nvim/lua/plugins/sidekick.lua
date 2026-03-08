local function open_skkeleton_composer(terminal)
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.max(60, math.floor(vim.o.columns * 0.6))
  local height = math.max(8, math.floor(vim.o.lines * 0.3))
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    style = 'minimal',
    border = 'rounded',
    title = ' Sidekick Compose ',
    title_pos = 'center',
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
  })

  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = 'sidekick-compose'
  vim.bo[buf].modifiable = true
  vim.wo[win].wrap = true
  vim.wo[win].linebreak = true
  vim.wo[win].conceallevel = 0

  local function close_composer()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    vim.schedule(function()
      if terminal and terminal.win and vim.api.nvim_win_is_valid(terminal.win) then
        terminal:focus()
      end
    end)
  end

  local function submit_composer()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local message = table.concat(lines, '\n')

    if message:match('^%s*$') then
      vim.notify('送信するテキストがありません。', vim.log.levels.WARN)
      return
    end

    close_composer()
    terminal:send(message)
    terminal:submit()
  end

  vim.keymap.set({ 'i', 'n' }, '<C-s>', submit_composer, { buffer = buf, silent = true, desc = 'Send to Sidekick' })
  vim.keymap.set('i', '<C-CR>', submit_composer, { buffer = buf, silent = true, desc = 'Send to Sidekick' })
  vim.keymap.set('i', '<C-Enter>', submit_composer, { buffer = buf, silent = true, desc = 'Send to Sidekick' })
  vim.keymap.set('n', 'q', close_composer, { buffer = buf, silent = true, desc = 'Close composer' })
  vim.keymap.set('n', '<Esc>', close_composer, { buffer = buf, silent = true, desc = 'Close composer' })
  vim.keymap.set('i', '<C-c>', close_composer, { buffer = buf, silent = true, desc = 'Close composer' })

  vim.notify('skkeleton で入力して <C-s> / <C-CR> で送信、<C-c> / q で閉じます。', vim.log.levels.INFO)
  vim.cmd.startinsert()
end

return {
  'folke/sidekick.nvim',
  cond = function()
    return os.getenv('PRIVATE_PLUGIN_ENABLED') ~= nil
  end,
  opts = {
    cli = {
      win = {
        keys = {
          compose_with_skkeleton = {
            '<C-g>',
            function(terminal)
              open_skkeleton_composer(terminal)
            end,
            mode = 'nt',
            desc = 'Compose with skkeleton',
          },
        },
      },
    },
  },
  keys = {
    {
      '<tab>',
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require('sidekick').nes_jump_or_apply() then
          return '<Tab>' -- fallback to normal tab
        end
      end,
      expr = true,
      desc = 'Goto/Apply Next Edit Suggestion',
    },
    {
      '<c-.>',
      function()
        require('sidekick.cli').toggle()
      end,
      desc = 'Sidekick Toggle',
      mode = { 'n', 't', 'i', 'x' },
    },
    {
      '<leader>aa',
      function()
        require('sidekick.cli').toggle()
      end,
      desc = 'Sidekick Toggle CLI',
    },
    {
      '<leader>as',
      function()
        require('sidekick.cli').select()
      end,
      -- Or to select only installed tools:
      -- require("sidekick.cli").select({ filter = { installed = true } })
      desc = 'Select CLI',
    },
    {
      '<leader>ad',
      function()
        require('sidekick.cli').close()
      end,
      desc = 'Detach a CLI Session',
    },
    {
      '<leader>at',
      function()
        require('sidekick.cli').send({ msg = '{this}' })
      end,
      mode = { 'x', 'n' },
      desc = 'Send This',
    },
    {
      '<leader>af',
      function()
        require('sidekick.cli').send({ msg = '{file}' })
      end,
      desc = 'Send File',
    },
    {
      '<leader>av',
      function()
        require('sidekick.cli').send({ msg = '{selection}' })
      end,
      mode = { 'x' },
      desc = 'Send Visual Selection',
    },
    {
      '<leader>ap',
      function()
        require('sidekick.cli').prompt()
      end,
      mode = { 'n', 'x' },
      desc = 'Sidekick Select Prompt',
    },
    {
      '<leader>ac',
      function()
        require('sidekick.cli').toggle({ name = 'copilot', focus = true })
      end,
      desc = 'Sidekick Toggle copilot',
    },
  },
}
