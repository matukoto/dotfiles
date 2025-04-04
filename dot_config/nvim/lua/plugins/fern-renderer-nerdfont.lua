-- dot_config/nvim/lua/plugins/fern-renderer-nerdfont.lua
-- Configuration for vim-fern-renderer-nerdfont extension
return {
  'lambdalisue/vim-fern-renderer-nerdfont',
  -- Dependencies: Requires fern.vim and vim-nerdfont
  dependencies = { 'lambdalisue/vim-fern', 'lambdalisue/vim-nerdfont' },
  -- Load when fern is loaded
  event = "VeryLazy",
  -- init function runs before the plugin is loaded, suitable for setting globals
  init = function()
    -- Set the fern renderer to use nerdfont icons
    vim.g['fern#renderer'] = 'nerdfont'
  end,
  -- No specific opts or config needed as configuration is done via globals
  opts = {},
}
