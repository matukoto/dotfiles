-- dot_config/nvim/lua/plugins/denops.lua
-- Configuration for vim-denops/denops.vim
return {
  'vim-denops/denops.vim',
  -- Load early as many other plugins depend on it
  lazy = false, -- Load immediately on startup
  -- init function runs before the plugin is loaded, suitable for setting globals
  init = function()
    -- Set Deno arguments for the Denops server
    vim.g['denops#server#deno_args'] = {
      '-q',             -- Quiet mode
      '--no-lock',      -- Disable lock file
      '-A',             -- Allow all permissions
      '--unstable-ffi', -- Enable unstable FFI API
      '--unstable-kv'   -- Enable unstable KV store API
    }

    -- Optional: Debug mode (uncomment if needed)
    -- vim.g['denops#debug'] = 1

    -- Optional: Shared server address (uncomment if using denops-shared-server)
    -- vim.g.denops_server_addr = "127.0.0.1:32123"
  end,
  -- No opts or config needed for denops itself
}
