require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'typescript',
    'tsx',
    'javascript',
    'vue',
    'vim',
    'svelte',
    'json',
    'markdown',
    'markdown_inline',
    'lua',
    'html',
    'css',
    'java',
    'yaml',
    'dot',
    'query',
    'go',
  },
  highlight = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
})
