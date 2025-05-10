local utils = require('lsp.utils')
---@type vim.lsp.Config
return {
  settings = {
    typescript = utils.tsAndJsInlayHints,
    javascript = utils.tsAndJsInlayHints,
    svelte = utils.tsAndJsInlayHints,
  },
}
