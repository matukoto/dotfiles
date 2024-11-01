require('which-key').setup({})

-- キーマップの登録
local wk = require('which-key')

wk.register({
  g = {
    name = 'LSP',
    d = { '<cmd>lua vim.lsp.buf.definition()<CR>', 'Go to Definition' },
    D = { '<cmd>vsplit lua vim.lsp.buf.definition()<CR>', 'Go to Definition in Split' },
    l = { vim.lsp.buf.implementation, 'Go to Implementation' },
    L = { '<cmd>Lspsaga peek_definition<CR>', 'Peek Definition' },
    t = { '<cmd>Lspsaga peek_type_definition<CR>', 'Peek Type Definition' },
    f = { '<cmd>Lspsaga finder ref<CR>', 'Find References' },
    r = { '<cmd>Lspsaga rename<CR>', 'Rename' },
    a = { '<cmd>Lspsaga code_action<CR>', 'Code Action' },
    b = { '<cmd>Lspsaga show_buf_diagnostics<CR>', 'Show Buffer Diagnostics' },
    w = { '<cmd>Lspsaga show_workspace_diagnostics<CR>', 'Show Workspace Diagnostics' },
    e = { vim.diagnostic.open_float, 'Open Diagnostic Float' },
    q = { vim.diagnostic.setqflist, 'Set Quickfix List' },
    ['['] = { '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Next Diagnostic' },
    [']'] = { '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Previous Diagnostic' },
  },
  ['<C-g>'] = {
    name = 'Gin',
    s = 'GinStatus',
    a = 'Gin add --all',
    c = 'Gin commit --quiet',
    P = 'GinPatch ++opener=tabnew ++no-head %',
    p = 'Gin push --quiet',
    l = 'GinLog ++opener=tabnew',
    b = 'GinBranch --all',
    d = 'GinDiff',
  },
})
