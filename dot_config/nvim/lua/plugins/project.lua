-- dot_config/nvim/lua/plugins/project.lua
return {
  'ahmedkhalf/project.nvim',
  -- Load early to detect project root on startup/buffer enter
  event = { 'BufEnter' },
  -- opts table passes configuration directly to setup()
  opts = {
    -- Manual mode doesn't automatically change root directory
    manual_mode = false,

    -- Detection methods: "lsp" uses Neovim LSP, "pattern" uses file patterns.
    -- Order matters for fallback.
    detection_methods = { 'lsp', 'pattern' },

    -- Patterns used for "pattern" detection method
    patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json' },

    -- LSP clients to ignore when detecting project root
    ignore_lsp = {},

    -- Directories to exclude from root detection
    exclude_dirs = {},

    show_hidden = false,

    -- Suppress message when changing directory
    silent_chdir = true,

    -- Scope for changing directory: 'global', 'tab', 'win'
    scope_chdir = 'global',

    datapath = vim.fn.stdpath('data') .. '/project_nvim', -- Ensure subdirectory exists
  },
  config = function(_, opts)
    require('project_nvim').setup(opts)
  end,
}
