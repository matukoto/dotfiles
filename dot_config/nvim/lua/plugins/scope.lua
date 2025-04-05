-- dot_config/nvim/lua/plugins/scope.lua
-- Configuration for scope.nvim - Per-tab UI scoping
return {
  'tiagovla/scope.nvim',
  -- Load early to manage UI elements correctly
  event = 'VeryLazy', -- Or "UIEnter" if needed earlier
  -- opts table passes configuration directly to setup()
  opts = {
    hooks = {
      -- Hook executed before leaving a tab
      pre_tab_leave = function()
        vim.api.nvim_exec_autocmds('User', { pattern = 'ScopeTabLeavePre', modeline = false })
      end,
      -- Hook executed after entering a tab
      post_tab_enter = function()
        vim.api.nvim_exec_autocmds('User', { pattern = 'ScopeTabEnterPost', modeline = false })
      end,
      -- Add other hooks if needed (pre_nvim_leave, post_nvim_enter)
    },
    -- Configure which UI elements are scoped (e.g., statusline, tabline)
    -- Defaults are usually sufficient unless specific scoping is needed.
    -- ui = {
    --   statusline = true,
    --   tabline = true,
    --   winbar = true,
    -- }
  },
  -- config function ensures setup is called after loading
  config = function(_, opts)
    require('scope').setup(opts)
  end,
}
