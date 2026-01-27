---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      -- library の手動設定を削除し、lazydev に任せる
      workspace = {
        checkThirdParty = false,
      },
      hint = {
        enable = true,
        await = true,
        paramName = 'Literal',
        paramType = true,
        semicolon = 'Disable',
        arrayIndex = 'Disable',
      },
      diagnostics = {
        groupFileStatus = { await = 'Opened' },
      },
      completion = { callSnippet = 'Replace' },
    },
  },
}
