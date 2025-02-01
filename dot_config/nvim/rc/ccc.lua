-- カラーピッカー/カラーエディタプラグイン（ccc.nvim）の設定

-- TrueColorサポートを有効化（カラーピッカーの正確な色表示に必要）
vim.opt.termguicolors = true

require('ccc').setup({
  -- プラグインの基本設定
  highlighter = {
    -- カラーハイライターの設定
    auto_enable = true,  -- ファイルを開いた時に自動的にハイライトを有効化
    lsp = true,         -- LSPのカラー情報を使用してハイライトを行う
  },
})
