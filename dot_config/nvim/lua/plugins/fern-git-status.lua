-- dot_config/nvim/lua/plugins/fern-git-status.lua
-- Configuration for vim-fern-git-status extension
return {
  'lambdalisue/vim-fern-git-status',
  -- Dependencies: Requires fern.vim
  dependencies = { 'lambdalisue/vim-fern' },
  -- Load when fern is loaded or specifically requested
  event = "VeryLazy",
  -- init function runs before the plugin is loaded, suitable for setting globals
  init = function()
    -- Disable status for ignored files (performance)
    vim.g['fern_git_status#disable_ignored'] = 1
    -- Enable status for untracked files
    vim.g['fern_git_status#disable_untracked'] = 0
    -- Disable status for submodules
    vim.g['fern_git_status#disable_submodules'] = 1
    -- Enable status for directories containing changes
    vim.g['fern_git_status#disable_directories'] = 0
  end,
  -- No opts or config needed
}
