-- wsl
-- for wsl2
if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'win32yank',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0,
  }
end

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
-- telescope-coc
require('telescope').load_extension('coc')
-- telescope
vim.keymap.set("n", "<leader>d", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>")

-- obsidian
--require('obsidian').setup({
--workspaces = {
--  { name = "my",
--  path = "~/obsidian"
--}}
--})

-- fidget
require('fidget').setup()

-- lualine
require('lualine').setup()

-- comment.nvim
require('Comment').setup(
  {
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
      ---Line-comment toggle keymap
      line = 'gcc',
      ---Block-comment toggle keymap
      block = 'gbc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      ---Line-comment keymap
      line = 'gc',
      ---Block-comment keymap
      block = 'gb',
    },
    ---LHS of extra mappings
    extra = {
      ---Add comment on the line above
      above = 'gcO',
      ---Add comment on the line below
      below = 'gco',
      ---Add comment at the end of line
      eol = 'gcA',
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
      ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
      basic = true,
      ---Extra mapping; `gco`, `gcO`, `gcA`
      extra = true,
    },
    ---Function to call before (un)comment
    pre_hook = nil,
    ---Function to call after (un)comment
    post_hook = nil,
  })

-- hlslens
require('hlslens').setup()

-- markdown.nvim
-- require('render-markdown').setup()

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
require('nvim-lastplace').setup {
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

--hawtkeys
require('hawtkeys').setup({
  colors = {
    normal = "#f5c359",
    insert = "#78ccc5",
    visual = "#9745be",
    replace = "#c75c6a",
    command = "#c75c6a",
  },
})

-- SmoothCursor
require('smoothcursor').setup()

-- aerial アウトラインを表示する
require("aerial").setup({
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})

-- アウトラインを表示、非表示を切り替える
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

-- term-edit
require 'term-edit'.setup {
  prompt_end = '%$ ',
}

require('full_visual_line').setup()

vim.keymap.set('n', '*', function()
  if vim.v.count > 0 then
    return '*'
  else
    return ':silent execute "keepj norm! *" <Bar> call winrestview(' ..
        vim.fn.string(vim.fn.winsaveview()) .. ')<CR>'
  end
end, { silent = true, expr = true })

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
    --"yaml",
    "go",
  },
  highlight = {
    enable = true,
  },
}
