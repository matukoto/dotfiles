-- 現在時刻を表示する
-- 参考 https://github.com/archibate/lualine-time/blob/main/lua/lualine/components/ctime.lua
local CTimeLine = require('lualine.component'):extend()
CTimeLine.init = function(self, options)
  CTimeLine.super.init(self, options)
end
CTimeLine.update_status = function(self)
  return os.date(self.options.format or '%H:%M', os.time())
end

require('lualine').setup({
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
      -- sources = {
      --   -- 'nvim_diagnostic',
      --   'nvim_lsp',
      -- },
      -- sections = { 'error', 'warn', 'info', 'hint' },
      -- diagnostics_color = {
      --   error = 'DiagnosticError',
      --   warn = 'DiagnosticWarn',
      --   info = 'DiagnosticInfo',
      --   hint = 'DiagnosticHint',
      -- },
      -- symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
      -- colored = true,
      -- update_in_insert = false,
      -- always_visible = false,
      -- {
      --   'filename',
      --   path = 1,
      --   file_status = true,
      --   shorting_target = 40,
      --   symbols = {
      --     modified = ' [+]',
      --     readonly = ' [RO]',
      --     unnamed = 'Untitled',
      --   },
      -- },
    },
    lualine_x = {
      {
        'copilot',
        show_colors = false,
      },
      'fileformat',
      'filetype',
    },
    lualine_y = { 'location', 'progress' },
    lualine_z = {
      CTimeLine,
    },
  },
  -- inactive_sections = {
  --   lualine_a = {},
  --   lualine_b = {},
  --   lualine_c = { 'filename' },
  --   lualine_x = { 'location' },
  --   lualine_y = {},
  --   lualine_z = {},
  -- },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
-- listen lsp-progress event and refresh lualine
vim.api.nvim_create_augroup('lualine_augroup', { clear = true })
vim.api.nvim_create_autocmd('User', {
  group = 'lualine_augroup',
  pattern = 'LspProgressStatusUpdated',
  callback = require('lualine').refresh,
})
