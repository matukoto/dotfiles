-- dot_config/nvim/lua/plugins/dial.lua
return {
  'monaqa/dial.nvim',
  -- Load lazily, triggered by keymaps
  event = 'VeryLazy',
  -- Define keymaps using the 'keys' table
  -- These keymaps will automatically load the plugin when triggered
  keys = {
    {
      '<C-a>', -- Increment in Normal mode
      function()
        -- Ensure the module is loaded before calling
        local dial_map_ok, dial_map = pcall(require, 'dial.map')
        if dial_map_ok then
          dial_map.manipulate('increment', 'normal')
        else
          vim.notify('dial.nvim not loaded correctly', vim.log.levels.WARN)
        end
      end,
      mode = 'n',
      desc = 'Increment (Dial)',
    },
    {
      '<C-x>', -- Decrement in Normal mode
      function()
        local dial_map_ok, dial_map = pcall(require, 'dial.map')
        if dial_map_ok then
          dial_map.manipulate('decrement', 'normal')
        else
          vim.notify('dial.nvim not loaded correctly', vim.log.levels.WARN)
        end
      end,
      mode = 'n',
      desc = 'Decrement (Dial)',
    },
    -- Add visual mode mappings if desired
    -- {
    --   "g<C-a>", -- Increment in Visual mode
    --   function()
    --     local dial_map_ok, dial_map = pcall(require, 'dial.map')
    --     if dial_map_ok then dial_map.manipulate('increment', 'visual') end
    --   end,
    --   mode = "v",
    --   desc = "Increment (Dial Visual)",
    -- },
    -- {
    --   "g<C-x>", -- Decrement in Visual mode
    --   function()
    --     local dial_map_ok, dial_map = pcall(require, 'dial.map')
    --     if dial_map_ok then dial_map.manipulate('decrement', 'visual') end
    --   end,
    --   mode = "v",
    --   desc = "Decrement (Dial Visual)",
    -- },
  },
  -- No explicit config or opts needed for basic functionality
  -- config = function()
  --   -- You could define augends or groups here if needed
  --   -- local augend = require("dial.augend")
  --   -- require("dial.config").augends:register_group{ ... }
  -- end,
}
