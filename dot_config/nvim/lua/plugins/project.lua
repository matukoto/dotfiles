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

    -- Show hidden files in Telescope integration (if telescope is loaded)
    show_hidden = false,

    -- Suppress message when changing directory
    silent_chdir = true,

    -- Scope for changing directory: 'global', 'tab', 'win'
    scope_chdir = 'global',

    -- Path for storing project history (used by Telescope integration)
    datapath = vim.fn.stdpath('data') .. '/project_nvim', -- Ensure subdirectory exists

    -- Configure Telescope integration (optional, requires telescope.nvim)
    -- telescope = { ... }
  },
  -- config function can be used for additional setup, like loading Telescope extension
  config = function(_, opts)
    require('project_nvim').setup(opts)

    -- Optional: Load the Telescope extension if Telescope is installed
    local telescope_ok, telescope = pcall(require, 'telescope')
    if telescope_ok then
      pcall(telescope.load_extension, 'projects')
      -- Add keymap for Telescope projects picker
      vim.keymap.set('n', '<leader>fp', '<cmd>Telescope projects<CR>', { desc = 'Find Projects' })
    end
  end,
}
