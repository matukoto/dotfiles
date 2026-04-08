vim.opt.runtimepath:append('~/.config/treesitter/repo/nvim-treesitter')

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
    'sql',
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
    additional_vim_regex_highlighting = { 'markdown' },
  },
  endwise = {
    enable = true,
  },
})
