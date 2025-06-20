return {
  'boltlessengineer/bufterm.nvim',
  config = function()
    require('bufterm').setup({
      save_native_terms = true, -- integrate native terminals from `:terminal` command
      start_in_insert = true, -- start terminal in insert mode
      remember_mode = false, -- remember vi_mode of terminal buffer
      enable_ctrl_w = false, -- use <C-w> for window navigating in terminal mode (like vim8)
      terminal = { -- default terminal settings
        buflisted = true, -- whether to set 'buflisted' option
        termlisted = false, -- list terminal in termlist (similar to buflisted)
        fallback_on_exit = true, -- prevent auto-closing window on terminal exit
        auto_close = true, -- auto close buffer on terminal job ends
      },
    })
  end,
}
