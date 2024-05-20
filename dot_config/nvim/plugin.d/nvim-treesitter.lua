require('nvim-treesitter.configs').setup({
  ensure_installed = {
    -- Neovim
    'query',
    'vimdoc',
    'vim',
    'lua',
    -- フロント
    'typescript',
    'tsx',
    'javascript',
    'vue',
    'svelte',
    'html',
    'css',
    --
    'java',
    'bash',
    'go',
    -- 'nu',
    'markdown',
    'markdown_inline',
    -- ファイル
    'dot',
    'json',
    'yaml',
    'toml',
  },
  highlight = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
})
