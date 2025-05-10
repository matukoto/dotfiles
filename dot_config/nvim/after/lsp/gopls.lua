---@type vim.lsp.Config
return {
  settings = {
    gopls = {
      analyses = { unusedparams = true, shadow = true },
      staticcheck = true,
      hints = {
        rangeVariableTypes = true,
        parameterNames = true,
        constantValues = true,
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        functionTypeParameters = true,
      },
    },
  },
}
