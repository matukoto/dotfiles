-- statusline を常に1つにする
vim.opt.laststatus = 3

if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'xsel -bi',
      ['*'] = 'xsel -bi',
    },
    paste = {
      ['+'] = function() return vim.fn.systemlist('xsel -bo | tr -d "\r"') end,
      ['*'] = function() return vim.fn.systemlist('xsel -bo | tr -d "\r"') end,
    },
    cache_enabled = 1,
  }
  -- vim.g.clipboard = {
  --   name = 'WslClipboard',
  --   copy = {
  --     ['+'] = 'xclip -selection clipboard',
  --     ['*'] = 'xclip -selection clipboard',
  --   },
  --   paste = {

  -- Windows クリップボードと連携できない
  -- \r が消える
  -- -- Vim のコピーで改行は消えない
  -- ['+'] = 'xclip -selection clipboard -o | tr -d "\r"',
  -- ['*'] = function() return vim.fn.systemlist('xclip -selection clipboard -o | tr -d "\r"') end,

  -- Windows クリップボードと連携できる
  -- \r が消える
  -- -- Vim のコピーでも改行が消えちゃう
  -- ['+'] = function() return vim.fn.systemlist('xclip -selection clipboard -o | tr -d "\r"') end,
  -- ['*'] = function() return vim.fn.systemlist('xclip -selection clipboard -o | tr -d "\r"') end,

  -- Windows クリップボードと連携できる
  -- \r が消えない
  -- -- Vim のコピーでも改行が消えちゃう
  -- ['+'] = function() return vim.fn.systemlist('xclip -selection clipboard -o') end,
  -- ['*'] = function() return vim.fn.systemlist('xclip -selection clipboard -o | tr -d "\r"') end,

  -- Windows クリップボードと連携できる
  -- \r が消えない
  -- Vim のコピーでも改行が消えちゃう
  -- ['+'] = function() return vim.fn.systemlist('xclip -selection clipboard -o') end,
  -- ['*'] = function() return vim.fn.systemlist('xclip -selection clipboard -o') end,

  -- Windows クリップボードと連携できない
  --['+'] = function() return vim.fn.systemList('xclip -selection clipboard -o | tr -d "\r"') end,
  --['*'] = function() return vim.fn.systemList('xclip -selection clipboard -o | tr -d "\r"') end,
  --   },
  --   cache_enabled = 1,
  -- }
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
    -- fzy_native = {
    -- override_generic_sorter = false,
    -- override_file_sorter = true,
    -- },
    coc = {
      -- trueだと常にpreviewを経由する
      prefer_locations = false,
    }
  }
}
require('telescope').load_extension('coc')
-- require('telescope').load_extension('fzy_native')

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

require("oil").setup({
  -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
  -- Set to false if you still want to use netrw.
  default_file_explorer = true,
  -- Id is automatically added at the beginning, and name at the end
  -- See :help oil-columns
  columns = {
    "icon",
    -- "permissions",
    -- "size",
    -- "mtime",
  },
  -- Buffer-local options to use for oil buffers
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },
  -- Window-local options to use for oil buffers
  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "nvic",
  },
  -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
  delete_to_trash = false,
  -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
  skip_confirm_for_simple_edits = false,
  -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
  -- (:help prompt_save_on_select_new_entry)
  prompt_save_on_select_new_entry = true,
  -- Oil will automatically delete hidden buffers after this delay
  -- You can set the delay to false to disable cleanup entirely
  -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
  cleanup_delay_ms = 2000,
  lsp_file_methods = {
    -- Time to wait for LSP file operations to complete before skipping
    timeout_ms = 1000,
    -- Set to true to autosave buffers that are updated with LSP willRenameFiles
    -- Set to "unmodified" to only save unmodified buffers
    autosave_changes = false,
  },
  -- Constrain the cursor to the editable parts of the oil buffer
  -- Set to `false` to disable, or "name" to keep it on the file names
  constrain_cursor = "editable",
  -- Set to true to watch the filesystem for changes and reload oil
  experimental_watch_for_changes = false,
  -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
  -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
  -- Additionally, if it is a string that matches "actions.<name>",
  -- it will use the mapping at require("oil.actions").<name>
  -- Set to `false` to remove a keymap
  -- See :help oil-actions for a list of all available actions
  keymaps = {
    ["?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = "actions.select_vsplit",
    ["<C-h>"] = "actions.select_split",
    -- ディレクトリを開く
    ["l"] = "actions.select",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["ge"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
  -- Configuration for the floating keymaps help window
  keymaps_help = {
    border = "rounded",
  },
  -- Set to false to disable all of the above keymaps
  use_default_keymaps = false,
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = false,
    -- This function defines what is considered a "hidden" file
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, ".")
    end,
    -- This function defines what will never be shown, even when `show_hidden` is set
    is_always_hidden = function(name, bufnr)
      return false
    end,
    -- Sort file names in a more intuitive order for humans. Is less performant,
    -- so you may want to set to false if you work with large directories.
    natural_order = true,
    sort = {
      -- sort order can be "asc" or "desc"
      -- see :help oil-columns to see which columns are sortable
      { "type", "asc" },
      { "name", "asc" },
    },
  },
  -- EXPERIMENTAL support for performing file operations with git
  git = {
    -- Return true to automatically git add/mv/rm files
    add = function(path)
      return false
    end,
    mv = function(src_path, dest_path)
      return false
    end,
    rm = function(path)
      return false
    end,
  },
  -- Configuration for the floating window in oil.open_float
  float = {
    -- Padding around the floating window
    padding = 2,
    max_width = 0,
    max_height = 0,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
    -- This is the config that will be passed to nvim_open_win.
    -- Change values here to customize the layout
    override = function(conf)
      return conf
    end,
  },
  -- Configuration for the actions floating preview window
  preview = {
    -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_width and max_width can be a single value or a list of mixed integer/float types.
    -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
    max_width = 0.9,
    -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
    min_width = { 40, 0.4 },
    -- optionally define an integer/float for the exact width of the preview window
    width = nil,
    -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_height and max_height can be a single value or a list of mixed integer/float types.
    -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
    max_height = 0.9,
    -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
    min_height = { 5, 0.1 },
    -- optionally define an integer/float for the exact height of the preview window
    height = nil,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
    -- Whether the preview window is automatically updated when the cursor is moved
    update_on_cursor_moved = true,
  },
  -- Configuration for the floating progress window
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = "rounded",
    minimized_border = "none",
    win_options = {
      winblend = 0,
    },
  },
  -- Configuration for the floating SSH window
  ssh = {
    border = "rounded",
  },
})

-- lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode', 'statusline_skk#mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = {
      {
        'filename',
        path = 1,
        file_status = true,
        shorting_target = 40,
        symbols = {
          modified = ' [+]',
          readonly = ' [RO]',
          unnamed = 'Untitled',
        }
      }
    },
    lualine_x = { 'searchcount' },
    --{
    --   'diagnostics',
    --   sources = {
    --     -- 'nvim_diagnostic',
    --     'nvim_lsp',
    --   },
    --
    --   sections = { 'error', 'warn', 'info', 'hint' },
    --
    --   diagnostics_color = {
    --     error = 'DiagnosticError',
    --     warn  = 'DiagnosticWarn',
    --     info  = 'DiagnosticInfo',
    --     hint  = 'DiagnosticHint',
    --   },
    --   symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
    --   colored = true,
    --   update_in_insert = false,
    --   always_visible = false,
    -- },
    lualine_y = { 'encoding', 'fileformat', 'filetype' },
    lualine_z = { 'location', 'progress' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

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

require('gitsigns').setup()

--require('scrollbar').setup()

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
  endwise = {
    enable = true,
  },
}
