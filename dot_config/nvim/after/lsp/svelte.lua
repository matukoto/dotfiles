local utils = require('lsp.utils')
---@type vim.lsp.Config
return {
  settings = {
    typescript = { inlayHints = utils.tsAndJsInlayHints },
    javascript = { inlayHints = utils.tsAndJsInlayHints },
    svelte = { inlayHints = utils.tsAndJsInlayHints },
  },
}
