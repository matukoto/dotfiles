return {
  'ruicsh/termite.nvim',
  cmd = { 'Termite' },
  opts = {
    width = 0.5,
    height = 0.5,
    position = 'bottom', -- Panel position: "left", "right", "top", or "bottom"
    start_insert = true,
    keymaps = {
      toggle = false,
      create = false,
      next = false,
      prev = false,
      focus_editor = false,
      normal_mode = false,
      maximize = false,
      close = false,
    },
    wo = { -- Window options applied to terminal windows
      winblend = 20,
    },
  },
  keys = {
    { '<C-/>', '<Cmd>Termite toggle<CR>', mode = { 'n', 't' }, desc = 'Termite toggle' },
    { '<C-t>', '<Cmd>Termite create<CR>', mode = { 'n', 't' }, desc = 'Termite create' },
    { '<C-n>', '<Cmd>Termite next<CR>', mode = { 't' }, desc = 'Termite next' },
    { '<C-p>', '<Cmd>Termite prev<CR>', mode = { 't' }, desc = 'Termite prev' },
    { '<C-e>', '<Cmd>Termite editor<CR>', mode = { 't' }, desc = 'Termite editor' },
    { '<C-z>', '<Cmd>Termite maximize<CR>', mode = { 't' }, desc = 'Termite maximize' },
    { '<C-q>', '<Cmd>Termite close<CR>', mode = { 't' }, desc = 'Termite close' },
  },
}
