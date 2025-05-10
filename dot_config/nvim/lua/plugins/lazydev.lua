return {
  'folke/lazydev.nvim',
  ft = 'lua',
  opts = {
    library = {
      {
        path = 'snacks.nvim/lua/snacks',
        'lazy.nvim',
        'luvit-meta/library',
        'plenary.nvim',
        '${3rd}/busted/library',
        '${3rd}/luassert/library',
      },
    },
  },
}
