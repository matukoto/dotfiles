local utils = require('lsp.utils')
---@type vim.lsp.Config
return {
  root_markers = {
    'deno.json',
    'deno.jsonc',
    'deps.ts',
  },
  -- singile_file_support と workspace_required はどちらも true では共存できない
  single_file_support = false,
  workspace_required = true,
  settings = {
    typescript = { inlayHints = utils.tsAndJsInlayHints },
    javascript = { inlayHints = utils.tsAndJsInlayHints },
  },
}
