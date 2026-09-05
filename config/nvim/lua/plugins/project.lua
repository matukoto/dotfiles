return {
  'DrKJeff16/project.nvim',
  lazy = false,
  opts = {
    lsp = {
      enabled = false,
      ignore = {},
      no_fallback = false,
    },
    manual_mode = false,
    patterns = { '.git', 'package.json' },
    exclude_dirs = {},
    silent_chdir = true,
    -- Use a global cwd so terminals and file explorers inherit the project root.
    scope_chdir = 'global',
  },
  config = function(_, opts)
    require('project').setup(opts)
  end,
}
