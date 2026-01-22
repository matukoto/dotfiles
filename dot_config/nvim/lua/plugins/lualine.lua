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
      globalstatus = false,
      refresh = {
        -- statusline = 1000,
        tabline = 1000,
        -- winbar = 1000,
      },
    },
    sections = {},
    winbar = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = {
        function()
          -- lspsagaがロードされているか確認してシンボルを取得
          local ok, saga_winbar = pcall(require, 'lspsaga.symbol.winbar')
          if ok then
            -- get_bar() でパンくずリストの文字列を取得
            local bar = saga_winbar.get_bar()
            return bar
          end
          return ''
        end,
      },
      lualine_x = { 'diagnostics', 'diff' },
      lualine_y = { 'filetype' },
      lualine_z = { 'location', 'progress' },
    },
    inactive_sections = {},
    tabline = {},
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
    -- opts.tabline.lualine_z = { time_line }

    -- local copilot_status = function()
    --   if vim.g.loaded_copilot == 1 and vim.fn['copilot#Enabled']() == 1 then
    --     return ' '
    --   else
    --     return ' '
    --   end
    -- end
    -- opts.tabline.lualine_x = { copilot_status }

    -- Apply the final configuration
    require('lualine').setup(opts)
  end,
}
