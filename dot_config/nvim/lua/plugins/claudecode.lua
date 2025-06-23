return {
  'coder/claudecode.nvim',
  dependencies = {
    'folke/snacks.nvim',
  },
  event = 'VeryLazy',
  cond = function()
    return os.getenv('PRIVATE_PLUGIN_ENABLED') ~= nil
  end,
  keys = {
    { '<leader>a', nil, desc = 'AI/Claude Code' },
    { '<leader>ac', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
    { '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
    { '<leader>ar', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
    { '<leader>aC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
    { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
    {
      '<leader>as',
      '<cmd>ClaudeCodeTreeAdd<cr>',
      desc = 'Add file',
      ft = { 'Fern', 'oil' },
    },
    -- Diff management
    -- { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
    -- { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
    {
      '<leader>an',
      function()
        local bufnr = vim.fn.bufnr('claudecode://prompt')
        if bufnr ~= -1 then
          local winid = vim.fn.bufwinid(bufnr)
          if winid ~= -1 then
            vim.api.nvim_set_current_win(winid)
          else
            vim.cmd(':drop claudecode://prompt')
          end
        else
          vim.cmd(':10new claudecode://prompt')
        end
      end,
      desc = 'Continue Claude',
    },
  },
  opts = {
    -- Server Configuration
    port_range = { min = 10000, max = 65535 }, -- WebSocket server port range
    auto_start = true, -- Auto-start server on Neovim startup
    log_level = 'info', -- "trace", "debug", "info", "warn", "error"
    terminal_cmd = nil, -- Custom terminal command (default: "claude")

    -- Selection Tracking
    track_selection = true, -- Enable real-time selection tracking
    visual_demotion_delay_ms = 50, -- Delay before demoting visual selection (ms)

    -- Connection Management
    connection_wait_delay = 200, -- Wait time after connection before sending queued @ mentions (ms)
    connection_timeout = 10000, -- Max time to wait for Claude Code connection (ms)
    queue_timeout = 5000, -- Max time to keep @ mentions in queue (ms)

    -- Terminal Configuration
    terminal = {
      split_side = 'right', -- "left" or "right"
      split_width_percentage = 0.40, -- Width as percentage (0.0 to 1.0)
      provider = 'snacks', -- "auto", "snacks", or "native"
      show_native_term_exit_tip = true, -- Show exit tip for native terminal
      auto_close = true, -- Auto-close terminal after command completion
    },

    -- Diff Integration
    diff_opts = {
      auto_close_on_accept = true, -- Close diff view after accepting changes
      show_diff_stats = true, -- Show diff statistics
      vertical_split = true, -- Use vertical split for diffs
      open_in_current_tab = true, -- Open diffs in current tab vs new tab
    },
  },
  config = function()
    require('claudecode').setup()
    vim.api.nvim_create_autocmd({ 'BufReadCmd' }, {
      pattern = { 'claudecode://prompt' },
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.api.nvim_set_option_value('filetype', 'markdown', { buf = bufnr })
        vim.api.nvim_set_option_value('buftype', 'nowrite', { buf = bufnr })
        vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = bufnr })
        vim.api.nvim_set_option_value('buflisted', false, { buf = bufnr })
        vim.api.nvim_set_option_value('modifiable', true, { buf = bufnr })
        vim.api.nvim_set_option_value('modified', false, { buf = bufnr })
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '<Cmd>q<CR>', { noremap = true, silent = true })
        vim.cmd('startinsert')
        vim.keymap.set('n', '<CR>', function()
          local claude_terminal_bufnr = require('claudecode.terminal').get_active_terminal_bufnr()
          if not claude_terminal_bufnr then
            return
          end
          local terminal_job_id = vim.fn.getbufvar(claude_terminal_bufnr, 'terminal_job_id')
          if not terminal_job_id then
            return
          end
          local current_win = vim.api.nvim_get_current_win()
          local prompt = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
          vim.fn.chansend(terminal_job_id, prompt)
          vim.cmd('ClaudeCodeFocus')
          vim.defer_fn(function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, false, true), 'n', false)
            vim.defer_fn(function()
              vim.api.nvim_set_current_win(current_win)
              vim.cmd('bw!')
            end, 100)
          end, 100)
        end, { noremap = true, silent = true, buffer = true })
      end,
    })
  end,
}
