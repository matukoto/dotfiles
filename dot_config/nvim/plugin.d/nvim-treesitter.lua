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
    'lua',
    'html',
    'css',
    'java',
    --"yaml",
    'go',
  },
  highlight = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
})
