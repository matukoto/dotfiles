-- dot_config/nvim/lua/plugins/lualine.lua

-- Custom component definition moved inside config function

return {
  -- Plugin specification for lazy.nvim
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = { 'BufReadPre' },
  -- Basic opts, custom component setup moved to config
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff' },
      lualine_c = {
        'diagnostics',
        -- Note: Original had commented out sub-options for diagnostics
        -- sources = { 'nvim_lsp' },
        -- sections = { 'error', 'warn', 'info', 'hint' },
        -- symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
      },
      lualine_x = {
        {},
        'fileformat',
        'filetype',
      },
      lualine_y = { 'location', 'progress' },
      -- lualine_z = { time_line }, -- Custom component added in config
      lualine_z = {}, -- Placeholder, will be updated in config
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location', 'overseer' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  },
  -- config function runs after the plugin is loaded
  config = function(_, opts)
    -- Define the custom component *after* lualine is loaded
    local time_line = require('lualine.component'):extend()
    time_line.init = function(self, options)
      time_line.super.init(self, options)
    end
    time_line.update_status = function(self)
      return os.date(self.options.format or '%H:%M', os.time())
    end

    -- Add the custom component to the opts table before setup
    opts.sections.lualine_z = { time_line }

    local copilot_status = function()
      if vim.g.loaded_copilot == 1 and vim.fn['copilot#Enabled']() == 1 then
        return ' '
      else
        return ' '
      end
    end
    opts.sections.lualine_x = { copilot_status }

    -- Apply the final configuration
    require('lualine').setup(opts)
  end,
}
