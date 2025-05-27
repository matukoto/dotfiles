return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  -- opts table passes configuration directly to setup()
  ---@type snacks.Config
  opts = {
    indent = {
      priority = 1,
      enabled = true, -- enable indent guides
      char = '│',
      only_scope = false, -- only show indent guides of the scope
      only_current = false, -- only show indent guides in the current window
      hl = 'SnacksIndent', ---@type string|string[] hl groups for indent guides
    },
    terminal = {
      win = {
        style = 'terminal',
      },
      start_insert = true,
      auto_insert = true,
    },
    dashboard = {
      preset = {
        keys = {
          {
            icon = ' ',
            key = 'f',
            desc = 'Files',
            action = ":lua Snacks.dashboard.pick('files')",
          },
          {
            icon = ' ',
            key = 'p',
            desc = 'project',
            action = ":lua Snacks.dashboard.pick('projects')",
          },
          {
            icon = ' ',
            key = 's',
            desc = 'git status',
            action = ':GinStatus',
          },
          { icon = ' ', key = 'i', desc = 'edit', action = ':ene | startinsert' },
          {
            icon = ' ',
            key = 'b',
            desc = 'Restore Session',
            action = '<cmd>SessionSearch<CR>',
          },
          {
            icon = ' ',
            key = 'g',
            desc = 'grep',
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
          {
            icon = ' ',
            key = 'r',
            desc = 'Recent',
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = ' ',
            key = 'c',
            desc = 'Config',
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          {
            icon = '󰒲 ',
            key = 'L',
            desc = 'Lazy',
            action = ':Lazy',
            enabled = package.loaded.lazy ~= nil,
          },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      sections = {
        --{ section = 'header' },
        { section = 'keys', padding = 1 },
        {
          pane = 1,
          icon = ' ',
          title = 'Recent Files',
          section = 'recent_files',
          indent = 2,
          padding = 1,
        },
        {
          pane = 2,
          icon = ' ',
          title = 'Git Status',
          section = 'terminal',
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = 'git status --short --branch --renames',
          height = 7,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        {
          pane = 2,
          icon = ' ',
          title = 'Projects',
          section = 'projects',
          indent = 2,
          padding = 1,
        },
        { section = 'startup' },
      },
    },
    picker = {
      sources = {
        sort = { fields = { 'idx', 'score:desc' } },
      },
      formatters = {
        file = {
          filename_first = true,
          truncate = 100,
        },
      },
      layout = {
        preset = 'dropdown', -- Use dropdown layout
        layout = {
          width = 0.8,
          min_width = 100,
          height = 0.9,
        },
      },
      win = {
        input = {
          -- Customize keymaps within the picker input window
          keys = {
            ['<c-a>'] = false, -- Disable select all
            ['<c-b>'] = false,
            ['<c-d>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
            ['<c-f>'] = false,
            ['<c-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
            ['<c-s>'] = false,
            ['<c-h>'] = { 'edit_split', mode = { 'i', 'n' } }, -- Edit in split
            ['<c-v>'] = { 'edit_vsplit', mode = { 'i', 'n' } }, -- Edit in split
            ['<c-t>'] = { 'edit_tab', mode = { 'i', 'n' } }, -- Edit in split
            -- Add other picker keymaps if needed
          },
        },
        -- Configure other picker window aspects if needed
        -- results = { ... },
        -- preview = { ... },
        -- prompt = { ... },
      },
    },
    -- Configure other snacks options if needed
    -- e.g., process management, notifications
  },
  -- Define global keymaps using the 'keys' table
  keys = {
    {
      '<C-w>',
      function()
        Snacks.bufdelete.delete()
      end,
      nowait = true,
      desc = 'Close Buffer (Snacks)',
    },
    {
      '<leader>u', -- Original keymap for buffer picker
      -- Ensure snacks is loaded before calling picker
      function()
        Snacks.terminal.toggle()
      end,
      desc = 'snacks terminal toggle',
    },
    {
      '<leader>f', -- Original keymap for buffer picker
      -- Ensure snacks is loaded before calling picker
      function()
        Snacks.picker.files()
      end,
      desc = 'Pick Files (Snacks)',
    },
    {
      '<leader>g', -- Original keymap for buffer picker
      function()
        Snacks.picker.grep()
      end,
      desc = 'Pick Greps (Snacks)',
    },
    {
      '<leader>b', -- Original keymap for buffer picker
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Pick Buffers (Snacks)',
    },
    {
      '<leader>o',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart Find Files',
    },
    {
      '<leader>:',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    -- {
    --   '<leader>n',
    --   function()
    --     Snacks.picker.notifications()
    --   end,
    --   desc = 'Notification History',
    -- },
    {
      '<leader>e',
      function()
        Snacks.explorer()
      end,
      desc = 'File Explorer',
    },
    -- find
    -- {
    --   '<leader>fb',
    --   function()
    --     Snacks.picker.buffers()
    --   end,
    --   desc = 'Buffers',
    -- },
    -- {
    --   '<leader>fc',
    --   function()
    --     Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
    --   end,
    --   desc = 'Find Config File',
    -- },
    -- {
    --   '<leader>fg',
    --   function()
    --     Snacks.picker.git_files()
    --   end,
    --   desc = 'Find Git Files',
    -- },
    {
      '<leader>p',
      function()
        Snacks.picker.projects()
      end,
      desc = 'Projects',
    },
    {
      '<leader>r',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent',
    },
    -- git
    {
      '<leader>B',
      function()
        Snacks.git.blame_line()
      end,
      desc = 'Git Branches',
    },
    -- {
    --   '<leader>gb',
    --   function()
    --     Snacks.picker.git_branches()
    --   end,
    --   desc = 'Git Branches',
    -- },
    -- {
    --   '<leader>gl',
    --   function()
    --     Snacks.picker.git_log()
    --   end,
    --   desc = 'Git Log',
    -- },
    -- {
    --   '<leader>gL',
    --   function()
    --     Snacks.picker.git_log_line()
    --   end,
    --   desc = 'Git Log Line',
    -- },
    -- {
    --   '<leader>gs',
    --   function()
    --     Snacks.picker.git_status()
    --   end,
    --   desc = 'Git Status',
    -- },
    -- {
    --   '<leader>gS',
    --   function()
    --     Snacks.picker.git_stash()
    --   end,
    --   desc = 'Git Stash',
    -- },
    -- {
    --   '<leader>gd',
    --   function()
    --     Snacks.picker.git_diff()
    --   end,
    --   desc = 'Git Diff (Hunks)',
    -- },
    -- {
    --   '<leader>gf',
    --   function()
    --     Snacks.picker.git_log_file()
    --   end,
    --   desc = 'Git Log File',
    -- },
    -- Grep
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>sB',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = 'Grep Open Buffers',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Visual selection or word',
      mode = { 'n', 'x' },
    },
    -- search
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = 'Registers',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.search_history()
      end,
      desc = 'Search History',
    },
    {
      '<leader>sa',
      function()
        Snacks.picker.autocmds()
      end,
      desc = 'Autocmds',
    },
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>sc',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>sC',
      function()
        Snacks.picker.commands()
      end,
      desc = 'Commands',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = 'Diagnostics',
    },
    {
      '<leader>sD',
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = 'Buffer Diagnostics',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help({
          win = {
            input = {
              keys = {
                ['<CR>'] = { 'edit_vsplit', mode = { 'i', 'n' } },
              },
            },
          },
        })
      end,
      desc = 'Help Pages',
    },
    {
      '<leader>sH',
      function()
        Snacks.picker.highlights()
      end,
      desc = 'Highlights',
    },
    {
      '<leader>si',
      function()
        Snacks.picker.icons()
      end,
      desc = 'Icons',
    },
    {
      '<leader>sj',
      function()
        Snacks.picker.jumps()
      end,
      desc = 'Jumps',
    },
    {
      '<leader>sK',
      function()
        Snacks.picker.keymaps()
      end,
      desc = 'Keymaps',
    },
    {
      '<leader>sl',
      function()
        Snacks.picker.loclist()
      end,
      desc = 'Location List',
    },
    {
      '<leader>sm',
      function()
        Snacks.picker.marks()
      end,
      desc = 'Marks',
    },
    {
      '<leader>sM',
      function()
        Snacks.picker.man()
      end,
      desc = 'Man Pages',
    },
    {
      '<leader>sp',
      function()
        Snacks.picker.lazy()
      end,
      desc = 'Search for Plugin Spec',
    },
    {
      '<leader>sq',
      function()
        Snacks.picker.qflist()
      end,
      desc = 'Quickfix List',
    },
    {
      '<leader>sR',
      function()
        Snacks.picker.resume()
      end,
      desc = 'Resume',
    },
    {
      '<leader>su',
      function()
        Snacks.picker.undo()
      end,
      desc = 'Undo History',
    },
    {
      '<leader>uC',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = 'Colorschemes',
    },
    -- LSP
    {
      'gd',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = 'Goto Definition',
    },
    {
      'gD',
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = 'Goto Declaration',
    },
    {
      'gr',
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = 'References',
    },
    {
      'gI',
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = 'Goto Implementation',
    },
    {
      'gy',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = 'Goto T[y]pe Definition',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = 'LSP Symbols',
    },
    {
      '<leader>sS',
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = 'LSP Workspace Symbols',
    },
    {
      '<leader>sk', -- Original keymap for kensaku picker
      function()
        local snacks_ok, snacks = pcall(require, 'snacks')
        local kensaku_source_ok, kensaku_source = pcall(require, 'plugins.snacks.sources.kensaku')
        if kensaku_source_ok then
          local sources_ok, sources = pcall(require, 'snacks.picker.config.sources')
          if sources_ok then
            sources.kensaku = kensaku_source
            snacks.picker.kensaku()
          else
            vim.notify('Failed to access snacks sources.', vim.log.levels.WARN)
          end
        else
          vim.notify('Failed to load custom kensaku source.', vim.log.levels.WARN)
        end
      end,
      desc = 'Pick Kensaku (Snacks)',
    },
  },
}
