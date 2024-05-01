local actions = require("telescope.actions")
require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        -- Ctrl+Enterがマッピングされている
        ["<F12>"] = actions.select_vertical,
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
      "trancate",
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
