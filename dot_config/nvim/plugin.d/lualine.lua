-- require('lsp-progress').setup({
--   client_format = function(client_name, spinner, series_messages)
--     if #series_messages == 0 then
--       return nil
--     end
--     return {
--       name = client_name,
--       body = spinner .. ' ' .. table.concat(series_messages, ', '),
--     }
--   end,
--   format = function(client_messages)
--     --- @param name string
--     --- @param msg string?
--     --- @return string
--     local function stringify(name, msg)
--       return msg and string.format('%s %s', name, msg) or name
--     end
--
--     local sign = '' -- nf-fa-gear \uf013
--     local lsp_clients = vim.lsp.get_active_clients()
--     local messages_map = {}
--     for _, climsg in ipairs(client_messages) do
--       messages_map[climsg.name] = climsg.body
--     end
--
--     if #lsp_clients > 0 then
--       table.sort(lsp_clients, function(a, b)
--         return a.name < b.name
--       end)
--       local builder = {}
--       for _, cli in ipairs(lsp_clients) do
--         if type(cli) == 'table' and type(cli.name) == 'string' and string.len(cli.name) > 0 then
--           if messages_map[cli.name] then
--             table.insert(builder, stringify(cli.name, messages_map[cli.name]))
--           else
--             table.insert(builder, stringify(cli.name))
--           end
--         end
--       end
--       if #builder > 0 then
--         return sign .. ' ' .. table.concat(builder, ', ')
--       end
--     end
--     return ''
--   end,
-- })

-- 現在時刻を表示する
-- 参考 https://github.com/archibate/lualine-time/blob/main/lua/lualine/components/ctime.lua
local CTimeLine = require('lualine.component'):extend()
local jst = 9 * 60 * 60
CTimeLine.init = function(self, options)
  CTimeLine.super.init(self, options)
end
CTimeLine.update_status = function(self)
  return os.date(self.options.format or '%H:%M', os.time() + jst)
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
      --'encoding',
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
