---@type vim.lsp.Config
return {
  settings = {
    typescript = SharedTsJsSettings.typescript,
    javascript = SharedTsJsSettings.javascript,
    svelte = {
      inlayHints = {
        parameterNames = { enabled = 'all' },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}
