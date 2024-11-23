vim.opt.termguicolors = true

require('ccc').setup({
  -- Your preferred settings
  -- Example: enable highlighter
  highlighter = {
    auto_enable = true,
    lsp = true,
  },
})
