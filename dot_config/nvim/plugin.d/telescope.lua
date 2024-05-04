local actions = require("telescope.actions")
require("telescope").setup {
  defaults = {
    initial_mode = "insert",
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-t>"] = actions.select_tab,
        ["<C-h>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<esc>"] = actions.close,
      },
      n = { ["q"] = actions.close },
    },
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      vertical = { width = 0.9 },
      prompt_position = "top",
      preview_cutoff = 1,
    },
    path_display = {
      filename_first = {
        reverse_directories = false,
      }
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
      sort_mru = true,
      ignore_current_buffer = true,
    },
  }
}
require('telescope').load_extension('smart_open')
-- telescope
vim.keymap.set("n", "<leader>d", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>o", "<cmd>Telescope smart_open<CR>")
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<CR>")
