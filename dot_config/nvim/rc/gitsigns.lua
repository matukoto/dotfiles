-- Gitsigns.nvim の設定
-- Gitの変更をバッファに表示するプラグイン

require('gitsigns').setup({
  current_line_blame = true, -- 現在の行のblameを表示
  current_line_blame_opts = {
    virt_text = true,              -- バーチャルテキストでblame情報を表示
    virt_text_pos = 'eol',         -- 行末に表示
    delay = 1000,                   -- 表示までの遅延時間（ミリ秒）
    ignore_whitespace = false,      -- 空白変更を無視しない
  },
  current_line_blame_formatter = '<author> <author_time:%Y-%m-%d> <summary>', -- blameのフォーマット
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    -- キーマッピングのヘルパー関数
    local function map(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- アクション用キーマッピング
    map('n', '<C-g><', gitsigns.stage_hunk)             -- hunkをステージ
    map('n', '<C-g>>', gitsigns.undo_stage_hunk)       -- hunkのステージを取り消し

    -- 以下のキーマッピングは必要に応じてコメントアウトを解除
    -- map('n', '<leader>hS', gitsigns.stage_buffer)    -- バッファ全体のhunkをステージ
    -- map('n', '<leader>hu', gitsigns.undo_stage_hunk) -- hunkのステージを取り消し
    -- map('n', '<leader>hR', gitsigns.reset_buffer)    -- バッファをリセット
    -- map('n', '<leader>hp', gitsigns.preview_hunk)    -- hunkのプレビュー
    -- map('n', '<leader>hb', function()
    --   gitsigns.blame_line({ full = true })          -- 完全なblame情報を表示
    -- end)
    -- map('n', '<leader>tb', gitsigns.toggle_current_line_blame) -- 現在行のblameをトグル
    -- map('n', '<leader>hd', gitsigns.diffthis)       -- 現在のdiffを表示
    -- map('n', '<leader>hD', function()
    --   gitsigns.diffthis('~')                        -- 特定の範囲のdiffを表示
    -- end)
    map('n', '<leader>td', gitsigns.toggle_deleted)     -- 削除行のハイライトをトグル

    -- テキストオブジェクト用キーマッピング
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>') -- hunkを選択
  end,
})

-- hunkを移動するキー設定
vim.api.nvim_set_keymap(
  'n',
  '<C-g>j',
  '&diff ? "]c" : "<cmd>Gitsigns next_hunk<CR>"',
  { expr = true, noremap = true }
)
vim.api.nvim_set_keymap(
  'n',
  '<C-g>k',
  '&diff ? "[c" : "<cmd>Gitsigns prev_hunk<CR>"',
  { expr = true, noremap = true }
)

-- blameの表示色を変更するための自動コマンド
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', {
      fg = '#888888', -- blameの文字色をより濃く設定
      -- bold = true, -- 太字にする場合はコメントアウトを解除
    })
  end,
})
