local utils = require('lsp.utils')
---@type vim.lsp.Config
return {
  root_markers = {
    'deno.json',
    'deno.jsonc',
    'deps.ts',
  },
  single_file_support = true,
  workspace_required = true,
  settings = {
    typescript = { inlayHints = utils.tsAndJsInlayHints },
    javascript = { inlayHints = utils.tsAndJsInlayHints },
  },
}
