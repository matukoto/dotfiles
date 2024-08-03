local qfs_actions = require('qfscope.actions')
local actions = require('telescope.actions')
require('telescope').setup({
  defaults = {
    initial_mode = 'insert',
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-n>'] = actions.move_selection_next,
        ['<C-p>'] = actions.move_selection_previous,
        ['<C-t>'] = actions.select_tab,
        ['<C-l>'] = actions.select_horizontal,
        ['<C-v>'] = actions.select_vertical,
        ['<esc>'] = actions.close,
        ['<C-g><C-f>'] = qfs_actions.qfscope_search_filename,
        ['<C-g><C-g>'] = qfs_actions.qfscope_grep_filename,
        ['<C-g><C-l>'] = qfs_actions.qfscope_grep_line,
        ['<C-g><C-t>'] = qfs_actions.qfscope_grep_text,
      },
      n = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-n>'] = actions.move_selection_next,
        ['<C-p>'] = actions.move_selection_previous,
        ['<C-t>'] = actions.select_tab,
        ['<C-h>'] = actions.select_horizontal,
        ['<C-v>'] = actions.select_vertical,
        ['q'] = actions.close,
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
  },
  pickers = {
    buffers = {
      initial_mode = 'normal',
      mappings = {
        n = {
          ['d'] = actions.delete_buffer,
        },
      },
      sort_mru = true,
      ignore_current_buffer = true,
    },
  },
})
require('telescope').load_extension('smart_open')
require('telescope').load_extension('kensaku')
require('telescope').load_extension('zk')
-- telescope
vim.keymap.set('n', '<leader>g', '<cmd>Telescope live_grep<CR>')
vim.keymap.set('n', '<leader>f', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<leader>o', '<cmd>Telescope smart_open<CR>')
vim.keymap.set('n', '<leader>b', '<cmd>Telescope buffers<CR>')
vim.keymap.set('n', '<Leader>zk', '<cmd>Telescope zk notes<CR>')
vim.keymap.set('n', '<Leader>zd', '<cmd>Telescope zk notes createdAfter=3 days ago<CR>')
vim.keymap.set('n', '<Leader>zt', '<cmd>Telescope zk tags<CR>')
-- vim.keymap.set('n', '<Leader>zk', '<cmd>Telescope zk tags created=today<CR>')
-- vim.api.nvim_set_keymap(
--   'n',
--   '<leader>k',
--   ':lua require("telescope").extensions.kensaku.kensaku{}<CR>',
--   { noremap = true, silent = true }
-- )
