return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false, -- lazy-loadingは非推奨
  build = ':TSUpdate',
  config = function()
    -- パーサーのリスト
    local parsers = {
      'query',
      'vimdoc',
      'vim',
      'lua',
      'fsharp',
      'make',
      -- Frontend
      'typescript',
      'tsx',
      'javascript',
      'vue',
      'svelte',
      'html',
      'css',
      -- Backend/Other
      'java',
      'groovy',
      'bash',
      'go',
      'sql',
      'nu',
      'markdown',
      'markdown_inline',
      -- Files
      'dot',
      'json',
      'yaml',
      'toml',
    }

    -- パーサーのインストール
    require('nvim-treesitter').install(parsers)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = parsers,
      callback = function()
        -- ハイライトを有効化
        vim.treesitter.start()
        -- フォールディング
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
        -- インデント
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
