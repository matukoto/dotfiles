-- dot_config/nvim/lua/plugins/camelcasemotion.lua
-- Configuration for bkad/CamelCaseMotion
return {
  'bkad/CamelCaseMotion',
  -- Load lazily, likely triggered by keymaps or specific events
  event = "VeryLazy",
  -- init function runs before the plugin is loaded, suitable for setting globals
  init = function()
    -- Set the trigger key for CamelCaseMotion
    vim.g.camelcasemotion_key = '['
    -- Note: Default keymaps are commented out in the original vimscript.
    -- If you want to enable default or custom keymaps, define them here
    -- using vim.keymap.set or within the 'keys' table of lazy.nvim spec.
    -- Example: Enable default 'w' motion
    -- vim.keymap.set('n', 'w', '<Plug>CamelCaseMotion_w', { silent = true })
  end,
  -- No opts or config needed
  -- keys = {
  --   -- Example: Define keymaps using lazy.nvim's keys table
  --   { "w", "<Plug>CamelCaseMotion_w", mode = "n", silent = true, desc = "Next CamelCase Word" },
  --   { "b", "<Plug>CamelCaseMotion_b", mode = "n", silent = true, desc = "Previous CamelCase Word" },
  --   { "iw", "<Plug>CamelCaseMotion_iw", mode = {"o", "x"}, silent = true, desc = "Inner CamelCase Word" },
  -- },
}
