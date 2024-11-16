require('ufo').setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end,
})
-- 折り畳んだあとの行数
vim.o.foldcolumn = '1'
-- 自動的に開かれる折り畳みレベル
vim.o.foldlevel = 99
-- 開始時の折り畳みレベル
vim.o.foldlevelstart = 99
-- 折り畳みを有効にする
vim.o.foldenable = true
-- ハイライトする
vim.o.foldtext = 'v:lua.vim.treesitter.foldtext()'
-- 折り畳みの設定 treesitter式の折り畳み
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- 折り畳み方法 expr を設定すると foldexpr で設定した折り畳み方法を使用する
vim.o.foldmethod = 'expr'

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
