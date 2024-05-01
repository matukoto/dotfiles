local actions = require("telescope.actions")
require("telescope").setup {
  defaults = {
    initial_mode = "insert",
    mappings = {
      i = {
        -- ["<C-n>"] = actions.move_selection_next,
        -- ["<C-p>"] = actions.move_selection_previous,
        ["<C-t>"] = actions.select_tab,
        ["<C-s>"] = actions.select_horizontal,
        -- "<C-h>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-c>"] = actions.close,
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
    extensions = {
      fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
      },
    }
  },
}
-- require('telescope').load_extension('fzy_native')
-- telescope
vim.keymap.set("n", "<leader>d", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>")
