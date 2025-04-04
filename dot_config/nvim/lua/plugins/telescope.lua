-- dot_config/nvim/lua/plugins/telescope.lua

-- Require actions needed for mappings within opts
local actions = require('telescope.actions')
-- qfscope actions might cause an error if qfscope isn't loaded yet when opts is defined.
-- It's safer to define mappings requiring external actions within the config function or lazy-load them.
-- For now, we'll try requiring it here, but might need adjustment.
local qfs_actions_ok, qfs_actions = pcall(require, 'qfscope.actions')
if not qfs_actions_ok then
  -- Assign dummy functions or notify if qfscope is essential for these mappings
  qfs_actions = {
    qfscope_search_filename = function()
      print('qfscope not loaded')
    end,
    qfscope_grep_filename = function()
      print('qfscope not loaded')
    end,
    qfscope_grep_line = function()
      print('qfscope not loaded')
    end,
    qfscope_grep_text = function()
      print('qfscope not loaded')
    end,
  }
  -- vim.notify("qfscope.actions not found for telescope mappings", vim.log.levels.WARN)
end

return {
  'nvim-telescope/telescope.nvim', -- Restore plugin name
  -- Dependencies are managed in the main plugins list (plenary, zf-native, sqlite, etc.)
  dependencies = { -- Restore dependencies
    'nvim-lua/plenary.nvim',
    { 'natecraddock/telescope-zf-native.nvim', build = 'make' },
    'kkharji/sqlite.lua',
    'danielfalk/smart-open.nvim',
    'atusy/qfscope.nvim', -- Needed for qfscope actions
    'cljoly/telescope-repo.nvim',
    'prochri/telescope-all-recent.nvim',
  },
  opts = {
    defaults = {
      initial_mode = 'insert',
      mappings = {
        i = {
          ['<C-j>'] = actions.move_selection_next,
          ['<C-n>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-p>'] = actions.move_selection_previous,
          ['<C-t>'] = actions.select_tab,
          ['<C-l>'] = actions.select_horizontal,
          ['<C-v>'] = actions.select_vertical,
          ['<esc>'] = actions.close,
          -- qfscope mappings (ensure qfscope is loaded)
          ['<C-g><C-f>'] = qfs_actions.qfscope_search_filename,
          ['<C-g><C-g>'] = qfs_actions.qfscope_grep_filename,
          ['<C-g><C-l>'] = qfs_actions.qfscope_grep_line,
          ['<C-g><C-t>'] = qfs_actions.qfscope_grep_text,
        },
        n = {
          ['<C-j>'] = actions.move_selection_next,
          ['<C-n>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-p>'] = actions.move_selection_previous,
          ['<C-t>'] = actions.select_tab,
          ['<C-l>'] = actions.select_horizontal,
          ['<C-v>'] = actions.select_vertical,
          ['q'] = actions.close,
          ['<esc>'] = actions.close,
        },
      },
      sorting_strategy = 'ascending',
      layout_strategy = 'vertical',
      layout_config = {
        vertical = { width = 0.9 },
        prompt_position = 'top',
        preview_cutoff = 1,
      },
      path_display = {
        filename_first = {
          reverse_directories = false,
        },
      },
      -- Other defaults can be added here
    },
    pickers = {
      buffers = {
        initial_mode = 'normal',
        mappings = {
          n = {
            -- Use actions.delete_buffer or a custom function
            ['<C-d>'] = actions.delete_buffer,
            -- Original custom function (alternative):
            -- ['<C-d>'] = function(prompt_bufnr)
            --   local entry = require('telescope.actions.state').get_selected_entry()
            --   if entry and entry.bufnr then
            --     vim.schedule(function() -- Defer deletion slightly
            --        pcall(vim.cmd, 'bdelete! ' .. entry.bufnr)
            --     end)
            --     actions.close(prompt_bufnr) -- Close telescope after initiating delete
            --   end
            -- end,
          },
        },
        sort_mru = true,
        ignore_current_buffer = true,
      },
      -- Configure other pickers if needed
    },
    extensions = {
      ['zf-native'] = {
        file = {
          enable = true,
          highlight_results = true,
          match_filename = true,
          initial_sort = nil,
          smart_case = true,
        },
        generic = {
          enable = true,
          highlight_results = true,
          match_filename = false,
          initial_sort = nil,
          smart_case = true,
        },
      },
      smart_open = {
        -- match_algorithm = 'zf', -- Uses zf-native by default if loaded
        disable_devicons = true,
      },
      repo = {
        list = {
          fd_opts = { '--no-ignore-vcs' },
          search_dirs = {
            '~/work',
            '~/.local/share/chezmoi', -- Use vim.fn.expand if ~ doesn't work reliably
            -- vim.fn.expand('~/work'),
            -- vim.fn.expand('~/.local/share/chezmoi'),
          },
          tail_path = true,
        },
      },
      -- Configuration for telescope-all-recent (moved inside extensions table)
      -- Note: This structure might differ based on the extension's design.
      -- Check telescope-all-recent docs if this doesn't work.
      -- It might need its own setup call in the config function instead.
      -- For now, assuming it merges under extensions:
      -- all_recent = { -- Hypothetical key, check extension docs
      --   database = { ... },
      --   scoring = { ... },
      --   default = { ... },
      --   pickers = { ... },
      -- }
    },
  },
  config = function(_, opts)
    -- Call the main telescope setup function with the options table
    require('telescope').setup(opts)

    -- Setup for telescope-all-recent (needs to be called separately)
    pcall(require('telescope-all-recent').setup, {
      database = {
        folder = vim.fn.stdpath('data'),
        file = 'telescope-all-recent.sqlite3',
        max_timestamps = 10,
      },
      debug = false,
      scoring = {
        recency_modifier = {
          [1] = { age = 240, value = 100 },
          [2] = { age = 1440, value = 80 },
          [3] = { age = 4320, value = 60 },
          [4] = { age = 10080, value = 40 },
          [5] = { age = 43200, value = 20 },
          [6] = { age = 129600, value = 10 },
        },
        boost_factor = 0.0001,
      },
      default = {
        disable = true,
        use_cwd = true,
        sorting = 'recent',
      },
      pickers = {
        man_pages = { disable = false, use_cwd = false, sorting = 'frecency' },
      },
    })

    -- Load extensions after setup
    require('telescope').load_extension('zf-native')
    require('telescope').load_extension('smart_open')
    -- require('telescope').load_extension('kensaku') -- Uncomment if kensaku is used
    require('telescope').load_extension('repo')
    pcall(require('telescope').load_extension, 'all_recent') -- Load the recent extension

    -- Define keymaps here, after telescope and extensions are loaded
    vim.keymap.set(
      'n',
      '<leader>g',
      '<cmd>Telescope live_grep<CR>',
      { desc = 'Telescope Live Grep' }
    )
    vim.keymap.set(
      'n',
      '<leader>f',
      '<cmd>Telescope find_files<CR>',
      { desc = 'Telescope Find Files' }
    )
    vim.keymap.set(
      'n',
      '<leader>o',
      '<cmd>Telescope smart_open<CR>',
      { desc = 'Telescope Smart Open' }
    )
    -- vim.keymap.set('n', '<leader>b', '<cmd>Telescope buffers<CR>', { desc = 'Telescope Buffers' }) -- Common mapping for buffers
    vim.keymap.set(
      'n',
      '<leader>h',
      '<cmd>Telescope help_tags<CR>',
      { desc = 'Telescope Help Tags' }
    ) -- Common mapping for help

    -- Zk specific mappings (ensure zk plugin/extension is loaded if needed)
    vim.keymap.set(
      'n',
      '<Leader>zk',
      '<cmd>Telescope zk notes<CR>',
      { desc = 'Telescope Zk Notes' }
    )
    vim.keymap.set(
      'n',
      '<Leader>zd',
      '<cmd>Telescope zk notes createdAfter=3 days ago<CR>',
      { desc = 'Telescope Zk Recent Notes' }
    )
    vim.keymap.set('n', '<Leader>zt', '<cmd>Telescope zk tags<CR>', { desc = 'Telescope Zk Tags' })

    -- Repo mapping
    vim.keymap.set(
      'n',
      '<Leader>R',
      '<cmd>Telescope repo list<CR>',
      { desc = 'Telescope Repo List' }
    )
    -- Registers mapping
    vim.keymap.set(
      'n',
      '<Leader>r',
      '<cmd>Telescope registers<CR>',
      { desc = 'Telescope Registers' }
    )

    -- Kensaku mapping (uncomment if used)
    -- vim.keymap.set('n', '<Leader>k', function() require('telescope').extensions.kensaku.kensaku() end, { desc = 'Telescope Kensaku' })
  end,
}
