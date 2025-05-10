---@type vim.lsp.Config
return {
  root_markers = {
    'package.json',
  },
  single_file_support = false,
  workspace_required = true,
  settings = SharedTsJsSettings,
}
