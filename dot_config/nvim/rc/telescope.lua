local qfs_actions = require('qfscope.actions')
local actions = require('telescope.actions')

require('telescope-all-recent').setup({
  database = {
    folder = vim.fn.stdpath('data'),
    file = 'telescope-all-recent.sqlite3',
    max_timestamps = 10,
  },
  debug = false,
  scoring = {
    recency_modifier = { -- also see telescope-frecency for these settings
      [1] = { age = 240, value = 100 }, -- past 4 hours
      [2] = { age = 1440, value = 80 }, -- past day
      [3] = { age = 4320, value = 60 }, -- past 3 days
      [4] = { age = 10080, value = 40 }, -- past week
      [5] = { age = 43200, value = 20 }, -- past month
      [6] = { age = 129600, value = 10 }, -- past 90 days
    },
    -- how much the score of a recent item will be improved.
    boost_factor = 0.0001,
  },
  default = {
    disable = true, -- disable any unkown pickers (recommended)
    use_cwd = true, -- differentiate scoring for each picker based on cwd
    sorting = 'recent', -- sorting: options: 'recent' and 'frecency'
  },
  pickers = { -- allows you to overwrite the default settings for each picker
    man_pages = { -- enable man_pages picker. Disable cwd and use frecency sorting.
      disable = false,
      use_cwd = false,
      sorting = 'frecency',
    },

    -- change settings for a telescope extension.
    -- To find out about extensions, you can use `print(vim.inspect(require'telescope'.extensions))`
    ['extension_name#extension_method'] = {
      -- [...]
    },
  },
})

require('telescope').setup({
  defaults = {
    -- tepescope を開いたときの最初のモード
    initial_mode = 'insert',
    mappings = {
      -- インサートモードでのマッピング
      i = {
        -- 次の候補へ移動
        ['<C-j>'] = actions.move_selection_next,
        ['<C-n>'] = actions.move_selection_next,
        -- 前の候補へ移動
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-p>'] = actions.move_selection_previous,
        -- タブで開く
        ['<C-t>'] = actions.select_tab,
        -- 水平分割で開く
        ['<C-l>'] = actions.select_horizontal,
        -- 垂直分割で開く
        ['<C-v>'] = actions.select_vertical,
        -- telescope をクローズ
        ['<esc>'] = actions.close,
        -- live_grep の後、さらに絞り込む
        ['<C-g><C-f>'] = qfs_actions.qfscope_search_filename,
        ['<C-g><C-g>'] = qfs_actions.qfscope_grep_filename,
        ['<C-g><C-l>'] = qfs_actions.qfscope_grep_line,
        ['<C-g><C-t>'] = qfs_actions.qfscope_grep_text,
      },
      -- ノーマルモードでのマッピング
      n = {
        -- 次の候補へ移動
        ['<C-j>'] = actions.move_selection_next,
        ['<C-n>'] = actions.move_selection_next,
        -- 前の候補へ移動
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-p>'] = actions.move_selection_previous,
        -- タブで開く
        ['<C-t>'] = actions.select_tab,
        -- 水平分割で開く
        ['<C-l>'] = actions.select_horizontal,
        -- 垂直分割で開く
        ['<C-v>'] = actions.select_vertical,
        -- telescope をクローズ
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
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
    smart_open = {
      match_algorithm = 'fzf',
      disable_devicons = false,
    },
    repo = {
      list = {
        fd_opts = {
          '--no-ignore-vcs',
        },
        search_dirs = {
          '~/work',
          '~/.local/share/chezmoi',
        },
        tail_path = true,
      },
    },
  },
  pickers = {
    buffers = {
      initial_mode = 'normal',
      mappings = {
        n = {
          ['<C-d>'] = actions.delete_buffer,
        },
      },
      sort_mru = true,
      ignore_current_buffer = true,
    },
  },
})

require('telescope').load_extension('smart_open')
-- require('telescope').load_extension('kensaku')
-- require('telescope').load_extension('zk')
require('telescope').load_extension('repo')
-- telescope
vim.keymap.set('n', '<leader>g', '<cmd>Telescope live_grep<CR>')
vim.keymap.set('n', '<leader>f', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<leader>o', '<cmd>Telescope smart_open<CR>')
vim.keymap.set('n', '<leader>b', '<cmd>Telescope buffers<CR>')
vim.keymap.set('n', '<Leader>zk', '<cmd>Telescope zk notes<CR>')
vim.keymap.set('n', '<Leader>zd', '<cmd>Telescope zk notes createdAfter=3 days ago<CR>')
vim.keymap.set('n', '<Leader>zt', '<cmd>Telescope zk tags<CR>')
vim.keymap.set('n', '<Leader>R', '<cmd>Telescope repo list<CR>')
vim.keymap.set('n', '<Leader>r', '<cmd>Telescope registers<CR>')
-- vim.keymap.set('n', '<Leader>zk', '<cmd>Telescope zk tags created=today<CR>')
-- vim.api.nvim_set_keymap(
--   'n',
--   '<leader>k',
--   ':lua require("telescope").extensions.kensaku.kensaku{}<CR>',
--   { noremap = true, silent = true }
-- )
