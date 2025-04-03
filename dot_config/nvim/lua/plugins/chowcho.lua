-- dot_config/nvim/lua/plugins/chowcho.lua
return {
  'tkmpypy/chowcho.nvim',
  -- Load lazily, triggered by the keymap
  event = "VeryLazy",
  -- opts table passes configuration directly to setup()
  opts = {
    -- Window selection labels (single characters)
    labels = { 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L' },

    -- Use default exclusion rules
    use_exclude_default = true,

    -- Ignore case for labels
    ignore_case = true,

    -- Custom exclusion function
    exclude = function(buf, win)
      -- Exclude noice command line popup
      local bt = vim.api.nvim_get_option_value('buftype', { buf = buf })
      local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })
      -- Check if buftype is 'nofile' and filetype is 'noice' or 'vim' (for cmdline)
      if bt == 'nofile' and (ft == 'noice' or ft == 'vim') then
        return true
      end
      -- Add other exclusions if needed, e.g., exclude aerial
      -- if ft == 'aerial' then return true end
      return false
    end,

    -- Selector appearance settings
    selector = {
      float = {
        border_style = 'rounded',
        icon_enabled = true,
        color = {
          label = {
            active = '#c8cfff',    -- Active window label color
            inactive = '#ababab',   -- Inactive window label color
          },
          text = {
            active = '#fefefe',    -- Active window text color
            inactive = '#d0d0d0',  -- Inactive window text color
          },
          border = {
            active = '#b400c8',    -- Active window border color
            inactive = '#fefefe',  -- Inactive window border color
          },
        },
        zindex = 100, -- Ensure it appears above most other floats
      },
    },
  },
  -- Define keymaps using the 'keys' table
  keys = {
    {
      "<Leader><Leader>", -- Trigger window selection
      function()
        require("chowcho").run()
      end,
      desc = "Select Window (Chowcho)",
    },
  },
  -- No explicit config function needed if opts and keys are sufficient
  -- config = function(_, opts)
  --   require('chowcho').setup(opts)
  --   -- Keymaps could also be defined here
  -- end,
}
