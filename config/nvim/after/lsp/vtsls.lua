local utils = require('lsp.utils')
---@type vim.lsp.Config
return {
  root_markers = {
    'package.json',
  },
  single_file_support = false,
  workspace_required = true,
  settings = {
    typescript = { inlayHints = utils.tsAndJsInlayHints },
    javascript = { inlayHints = utils.tsAndJsInlayHints },
    tsserver = {
      pluginPaths = { '.' },
      globalPlugins = {
        {
          name = 'typescript-svelte-plugin',
          enableForWorkspaceTypeScriptVersions = true,
          languages = { 'svelte' },
        },
      },
    },
  },
}
