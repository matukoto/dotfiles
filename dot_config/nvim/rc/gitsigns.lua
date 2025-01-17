require('gitsigns').setup({
  current_line_blame = true, -- 現在の行のblameを表示
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 行末に表示
    delay = 1000, -- 遅延なしで即時表示
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author> <author_time:%Y-%m-%d> <summary>',
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    -- Actions
    map('n', '<C-g><', gitsigns.stage_hunk)
    map('n', '<C-g>>', gitsigns.undo_stage_hunk)

    -- map('n', '<leader>hS', gitsigns.stage_buffer)
    -- map('n', '<leader>hu', gitsigns.undo_stage_hunk)
    -- map('n', '<leader>hR', gitsigns.reset_buffer)
    -- map('n', '<leader>hp', gitsigns.preview_hunk)
    -- map('n', '<leader>hb', function()
    --   gitsigns.blame_line({ full = true })
    -- end)
    -- map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    -- map('n', '<leader>hd', gitsigns.diffthis)
    -- map('n', '<leader>hD', function()
    --   gitsigns.diffthis('~')
    -- end)
    map('n', '<leader>td', gitsigns.toggle_deleted)

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
})

-- hunk を移動する
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

-- blame の色を変更
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', {
      fg = '#888888', -- より濃い色に変更
      -- bold = true, -- 太字にする
    })
  end,
})
