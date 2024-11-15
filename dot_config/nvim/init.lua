-- Vimホームディレクトリの設定
-- vim.g.VIMHOME = vim.fn.expand('<sfile>:p:h')
-- local is_windows = vim.fn.has('win32') == 1

-- ステータスラインを常に1つにする
vim.opt.laststatus = 3

-- 文字コードと改行コードの設定
vim.opt.encoding = 'utf-8'
vim.opt.fileencodings = 'utf-8'
vim.opt.fileformats = { 'unix', 'dos' }

-- ウィンドウの開き方
vim.opt.splitbelow = true
vim.opt.splitright = true

-- カーソル位置の表示
vim.opt.ruler = true
vim.opt.cursorline = true

-- タブとインデントの設定
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- ビジュアルモードでのペースト
vim.keymap.set('x', 'p', 'P')
vim.keymap.set('x', 'P', 'p')

-- diff設定
vim.opt.diffopt = 'internal,filler,algorithm:histogram,indent-heuristic'

-- 折り返し設定
vim.opt.breakindent = true
vim.opt.breakindentopt = 'shift:0'

-- 対応する括弧の表示
vim.opt.showmatch = true
vim.opt.matchtime = 1

-- 検索設定
vim.opt.wrapscan = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- ヘルプ言語
vim.opt.helplang = { 'ja', 'en' }

-- ターミナルモード
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>')

-- 行番号表示
vim.opt.number = true

-- swapファイル無効化
vim.opt.swapfile = false

-- スクロール時の表示行数
vim.opt.scrolloff = 10

-- xキーの削除動作
vim.keymap.set({ 'n', 'v' }, 'x', '"_x')

-- vvで行末まで選択
vim.keymap.set('v', 'v', '^$h')

-- インデント変更
vim.keymap.set('n', '>', '>>')
vim.keymap.set('n', '<', '<<')

-- ;と:の入れ替え
vim.keymap.set({ 'n', 'v' }, ';', ':')
vim.keymap.set({ 'n', 'v' }, ':', ';')

-- j, kの移動
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'J', 'gJ')

vim.keymap.set('n', '<ESC>', '<Cmd>nohlsearch<CR><ESC>')
-- クリップボード連携
vim.opt.clipboard = 'unnamedplus'

-- マウス有効化
vim.opt.mouse = 'a'

-- 置換コマンドの簡略化
vim.cmd([[
cnoreabbrev <expr> s getcmdtype() .. getcmdline() ==# ':s' ? [getchar(), ''][1] .. "%s///g<Left><Left>" : 's'
]])

-- 大文字小文字を区別して検索
vim.keymap.set('n', '<Space>/', '/\\C')
vim.keymap.set('n', '<Space>?', '?\\C')

-- gitコミットメッセージ
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*commit',
  callback = function()
    vim.keymap.set(
      'n',
      '<CR><CR>',
      '<Cmd>silent! execute \'normal! ^w"zdiw"_dip"zPA: \' | startinsert!<CR>',
      { buffer = true }
    )
  end,
})

-- タブを閉じて左に移動する関数
function CloseTabAndMoveLeft()
  if vim.fn.tabpagenr('$') > 1 then
    vim.cmd('tabprevious')
    vim.cmd('tabclose #')
  else
    vim.cmd('tabclose')
  end
end

vim.api.nvim_create_user_command('TCL', CloseTabAndMoveLeft, {})

-- 不要なプラグインの無効化
if vim.fn.has('vim_starting') == 1 then
  local disabled_plugins = {
    'gzip',
    'tar',
    'tarPlugin',
    'zip',
    'zipPlugin',
    'rrhelper',
    '2html_plugin',
    'vimball',
    'vimballPlugin',
    'getscript',
    'getscriptPlugin',
    'logipat',
    'matchparen',
    'man',
    'netrw',
    'netrwPlugin',
    'netrwSettings',
    'netrwFileHandlers',
  }
  for _, plugin in ipairs(disabled_plugins) do
    vim.g['loaded_' .. plugin] = 1
  end
end

-- マッピングプレフィックス
vim.g.mapleader = ' '
vim.keymap.set({ 'n', 'x' }, '<Leader>', '<Nop>')

-- ウィンドウ移動
for _, key in ipairs({ 'h', 'j', 'k', 'l' }) do
  vim.keymap.set('n', '<Leader>' .. key, '<C-w>' .. key, { silent = true })
end

-- タブ操作
vim.keymap.set('n', 'H', '<Cmd>tabprevious<CR>', { silent = true })
vim.keymap.set('n', 'L', '<Cmd>tabnext<CR>', { silent = true })
vim.keymap.set('n', 'Q', '<Cmd>TCL<CR>', { silent = true })
vim.cmd('cabbrev qq TCL')

vim.keymap.set('n', '<Leader>p', '"*p', { silent = true })

vim.cmd('cabbrev cm <Cmd>Capture message<CR>')

-- dvpmの初期化
vim.g['denops#server#deno_args'] = { '-q', '--no-lock', '-A', '--unstable-ffi', '--unstable-kv' }
local denops = vim.fn.expand('~/.cache/nvim/dvpm/github.com/vim-denops/denops.vim')
if not vim.loop.fs_stat(denops) then
  vim.fn.system({ 'git', 'clone', 'https://github.com/vim-denops/denops.vim', denops })
end
vim.opt.runtimepath:prepend(denops)

vim.g.dvpm_typescript_file = vim.fn.expand('~/.config/dvpm/denops/config/dvpm.ts')
if vim.g.dvpm_typescript_file and vim.fn.filereadable(vim.g.dvpm_typescript_file) == 1 then
  vim.fn['denops#plugin#load']('dvpm')
  vim.fn['denops#notify']('dvpm', 'load', { vim.g.dvpm_typescript_file })
end

-- リドゥ
vim.keymap.set('n', 'U', '<C-r>')

-- カーソル移動時に中央に
vim.api.nvim_create_autocmd('CursorMoved', {
  pattern = '*',
  command = 'normal! zz',
})

-- カラースキーム
-- vim.cmd('colorscheme everforest')
