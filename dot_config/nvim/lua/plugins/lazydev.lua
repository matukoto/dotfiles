-- dot_config/nvim/lua/plugins/lazydev.lua
-- Configuration for lazydev.nvim - enhances Neovim Lua development experience
return {
  'folke/lazydev.nvim',
  ft = 'lua', -- Load when a lua file is opened
  -- opts can be used to configure lazydev (using defaults here)
  opts = {
    -- library = { ... } -- Configure library paths if needed
    -- plugins = { ... } -- Configure plugin spec locations if needed
  },
  -- No explicit config or keys needed for default setup
}
