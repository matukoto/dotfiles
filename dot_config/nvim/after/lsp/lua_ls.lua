---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file('', true) }, -- Include vim runtime paths
      hint = {
        enable = true,
        await = true,
        paramName = 'Literal',
        paramType = true,
        semicolon = 'Disable',
        arrayIndex = 'Disable',
      },
      diagnostics = { globals = { 'vim' }, groupFileStatus = { await = 'Opened' } }, -- Recognize vim global
      completion = { callSnippet = 'Replace' }, -- Better snippet handling
    },
  },
}
