-- telescope
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
  },
  extensions = {
    frecency = {
      show_scores = true
    },
    coc = {
      -- trueだと常にpreviewを経由する
      prefer_locations = false,
    }
  }
}
-- telescope-frecency
require('telescope').load_extension('frecency')
-- telescope-coc
require('telescope').load_extension('coc')
-- telescope
vim.keymap.set("n", "<leader>a", "<cmd>Telescope frecency<CR>")
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>")

-- lualine
require('lualine').setup()

-- comment.nvim
require('Comment').setup()

-- hlslens
require('hlslens').setup()

-- hlchunk
require("hlchunk").setup({
  chunk = {
    enable = true,
    notify = true,
    use_treesitter = true,
    -- details about support_filetypes and exclude_filetypes in https://github.com/shellRaining/hlchunk.nvim/blob/main/lua/hlchunk/utils/filetype.lua
    -- support_filetypes = ft.support_filetypes,
    -- exclude_filetypes = ft.exclude_filetypes,
    chars = {
      horizontal_line = "─",
      vertical_line = "│",
      left_top = "╭",
      left_bottom = "╰",
      right_arrow = ">",
    },
    style = {
      { fg = "#806d9c" },
      { fg = "#c21f30" }, -- this fg is used to highlight wrong chunk
    },
    textobject = "",
    max_file_size = 1024 * 1024,
    error_sign = true,
  },
  indent = {
    enable = false
  },
  line_num = {
    enable = false
  },
  blank = {
    enable = false
  }
})

-- nvim-lastplace
require 'nvim-lastplace'.setup {
  lastplace_ignore_buftype = { "quicfix", "nofile", "help" },
  lastplace_ignore_filetype = { "gitcommit", "gitrebase" },
  lastplace_open_folds = true
}

-- modes.nvim
-- require('modes').setup({
-- 	colors = {
-- 		copy = "#f5c359",
-- 		delete = "#c75c6a",
-- 		insert = "#78ccc5",
-- 		visual = "#9745be",
-- 	},
-- })

-- SmoothCursor
require('smoothcursor').setup()

-- aerial アウトラインを表示する
require("aerial").setup()
-- アウトラインを表示、非表示を切り替える
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

-- term-edit
require 'term-edit'.setup {
  prompt_end = '%$ ',
}

-- treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "typescript",
    "tsx",
    "javascript",
    "vue",
    "vim",
    "svelte",
    "json",
    "markdown",
    "lua",
    "html",
    "css",
    "java",
    "yaml",
    "go",
  },
  highlight = {
    enable = true,
  },
}
