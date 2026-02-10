-- local is_windows = vim.fn.has('win32') == 1

-- statusline を非表示にする (tablineに表示する)
vim.opt.laststatus = 0
vim.opt.cmdheight = 0

-- 文字コードの自動判別
vim.opt.encoding = 'utf-8'
vim.opt.fileencodings = 'utf-8'

-- 改行コードの自動認識
vim.opt.fileformats = 'unix,dos'

-- 新しいウィンドウを下､右に開く
vim.opt.splitbelow = true
vim.opt.splitright = true

-- カーソルの位置を%で表示
vim.opt.ruler = true

-- カーソル行の背景色変更
vim.opt.cursorline = true
-- 折り畳んだあとの行数
vim.opt.foldcolumn = '1'
-- 自動的に開かれる折り畳みレベル
vim.opt.foldlevel = 99
-- 開始時の折り畳みレベル
vim.opt.foldlevelstart = 99
-- 折り畳みを有効にする
vim.opt.foldenable = true

-- タブ
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- インデントにスペースを使用
vim.opt.expandtab = true

-- 改行時に自動インデント
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Vim のビジュアルモードでは p を使うと、無名レジスタに選択したテキストがコピーされる
vim.keymap.set('x', 'p', 'P')
vim.keymap.set('x', 'P', 'p')

-- vim diff
vim.opt.diffopt:append('internal,filler,algorithm:histogram,indent-heuristic')

-- 折返したときもインデント
vim.opt.breakindent = true

-- 折り返したときにインデントの深さを同じに
vim.opt.breakindentopt = 'shift:0'

-- 対応する括弧やブレースを表示
vim.opt.showmatch = true
vim.opt.matchtime = 1 -- 表示時間 (1/10秒)

--検索をファイルの先頭へ循環しない
vim.opt.wrapscan = false

-- ヘルプを日本語優先に
vim.opt.helplang = 'ja,en'

-- ターミナルモード
-- esc
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

--行番号を表示
vim.opt.number = true
--大文字小文字の区別なし
vim.opt.ignorecase = true

-- swap しない
vim.opt.swapfile = false

-- 外部更新を自動検知
vim.opt.autoread = true
vim.opt.updatetime = 1000

--検索時に大文字を含んでいたら大/小を区別
vim.opt.smartcase = true

--検索対象をハイライト
vim.opt.hlsearch = true
-- Escでハイライト消去
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR><Esc>', { silent = true })
--スクロール時に表示を10行確保
vim.opt.scrolloff = 10

--x キー削除でデフォルトレジスタに入れない
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('v', 'x', '"_x')

--vv で行末まで選択
vim.keymap.set('v', 'v', '^$h')

-- インデントを手軽に変更
vim.keymap.set('n', '>', '>>')
vim.keymap.set('n', '<', '<<')

-- ; と : の入れ替え
vim.keymap.set('n', ';', ':')
vim.keymap.set('n', ':', ';')
vim.keymap.set('v', ';', ':')
vim.keymap.set('v', ':', ';')

-- 相対的な行番号を表示
-- vim.opt.relativenumber = true

-- j, k による移動を折り返されたテキストでも自然に振る舞うように変更
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'J', 'gJ')

-- 動作環境との統合
-- OSのクリップボードをレジスタ指定無しで Yank, Put 出来るようにする
vim.opt.clipboard = 'unnamedplus'
-- マウスの入力を受け付ける
vim.opt.mouse = 'a'

-- 置換を簡単に monaqaさん
-- https://zenn.dev/vim_jp/articles/2023-06-30-vim-substitute-tips
vim.cmd([[ cnoreabbrev <expr> s getcmdtype() .. getcmdline() ==# ':s' ? [getchar(), ''][1] .. "%s///g<Left><Left>" : 's' ]])
-- visual mode の範囲選択をした状態でも同じことをしたい
-- vim.cmd([[ cnoreabbrev <expr> s getcmdtype() .. getcmdline() ==# ':\'\<\,\'\>s' ? [getchar(), ''][1] .. "%s///g<Left><Left>" : 's' ]])

-- 大文字小文字を区別して検索(デフォルトは区別しない)
-- https://zenn.dev/igrep/articles/2023-08-vim-backslash-c
vim.keymap.set('n', '<Space>/', '/\\C')
vim.keymap.set('n', '<Space>?', '?\\C')

-- git commit message
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*commit',
  callback = function()
    vim.keymap.set('n', '<CR><CR>', function()
      vim.cmd('normal! ^w"zdiw')
      vim.cmd('normal! "_dip')
      vim.cmd('normal! "zPA(): ')
      vim.cmd('normal! 2h')
      vim.api.nvim_command('startinsert')
    end, { buffer = true })
  end,
})

-- タブを閉じた後に左のタブに移動する関数
local function CloseTabAndMoveLeft()
  local current_tab = vim.fn.tabpagenr()
  local last_tab = vim.fn.tabpagenr('$')
  if last_tab > 1 then
    vim.cmd('tabprevious')
    vim.cmd('tabclose ' .. current_tab)
  else
    vim.cmd('tabclose')
  end
end

-- :TCL コマンドでカスタム関数を実行
vim.api.nvim_create_user_command('TCL', CloseTabAndMoveLeft, {})

-- Disable unnecessary default plugins on startup
if vim.fn.has('vim_starting') == 1 then
  vim.g.loaded_gzip = 1
  vim.g.loaded_tar = 1
  vim.g.loaded_tarPlugin = 1
  vim.g.loaded_zip = 1
  vim.g.loaded_zipPlugin = 1
  vim.g.loaded_rrhelper = 1
  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_vimball = 1
  vim.g.loaded_vimballPlugin = 1
  vim.g.loaded_getscript = 1
  vim.g.loaded_getscriptPlugin = 1
  vim.g.loaded_logipat = 1
  vim.g.loaded_matchparen = 1
  vim.g.loaded_man = 1
  -- NOTE: Netrw is used to download a missing spellfile
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_netrwSettings = 1
  vim.g.loaded_netrwFileHandlers = 1
end

-- map prefix
vim.g.mapleader = ' '
vim.keymap.set('n', '<Leader>', '<Nop>')
vim.keymap.set('x', '<Leader>', '<Nop>')

-- ウィンドウ移動
vim.keymap.set('n', '<Leader>h', '<C-w>h', { silent = true })
vim.keymap.set('n', '<Leader>j', '<C-w>j', { silent = true })
vim.keymap.set('n', '<Leader>k', '<C-w>k', { silent = true })
vim.keymap.set('n', '<Leader>l', '<C-w>l', { silent = true })

-- タブ
vim.keymap.set('n', 'H', '<Cmd>tabprevious<CR>', { silent = true })
vim.keymap.set('n', 'L', '<Cmd>tabnext<CR>', { silent = true })
vim.keymap.set('n', 'Q', '<Cmd>TCL<CR>', { silent = true })
vim.cmd('cabbrev qq TCL')
vim.cmd('cabbrev rs restart')

vim.keymap.set('n', '<Leader>p', '"*p', { silent = true })

vim.cmd('cabbrev cm <Cmd>Capture message<CR>')
vim.cmd('cabbrev h tab help')
vim.cmd('cabbrev H vert help')
vim.cmd('cabbrev lspinfo checkhealth vim.lsp')

-- リドゥ
vim.keymap.set('n', 'U', '<C-r>')

vim.keymap.set('n', 'g<C-a>', 'ggVG')
vim.keymap.set('n', 'g<C-a>y', 'ggVGy')
vim.keymap.set('n', '<C-z>', '<Cmd>wq<CR>')

-- Save view on leave
local save_view_group = vim.api.nvim_create_augroup('SaveViewOnLeave', { clear = true })
vim.api.nvim_create_autocmd('BufWinLeave', {
  pattern = '*',
  group = save_view_group,
  callback = function()
    if vim.bo.filetype ~= '' and vim.fn.expand('%') ~= '' then
      vim.cmd('mkview')
    end
  end,
})

-- Restore view on enter
local restore_view_group = vim.api.nvim_create_augroup('RestoreViewOnEnter', { clear = true })
vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  group = restore_view_group,
  callback = function()
    if vim.bo.filetype ~= '' and vim.fn.expand('%') ~= '' then
      vim.cmd('silent! loadview')
    end
  end,
})

-- -- Center screen on cursor move
-- vim.api.nvim_create_autocmd('CursorMoved', {
--   pattern = '*',
--   command = 'normal! zz',
-- })

require('config.auto_reload')

-- terminal を縦分割で開く
vim.cmd('cabbrev t ' .. 'vsplit term://' .. vim.o.shell)

-- colorscheme
-- vim.cmd('colorscheme everforest') -- Set your desired colorscheme here
vim.lsp.log._set_filename(vim.fn.stdpath('log') .. '/lsp/lsp-' .. os.date('%y') .. os.date('%m') .. os.date('%d') .. '.log')

require('config.lazy')
