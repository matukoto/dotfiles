return {
  'atusy/jab.nvim',
  event = 'VeryLazy',
  keys = {
    {
      ':',
      function()
        return require('jab').jab_win()
      end,
      mode = { 'n', 'x', 'o' },
      expr = true,
      desc = 'Jab: incremental search',
    },
    {
      'f',
      function()
        return require('jab').f()
      end,
      mode = { 'n', 'x', 'o' },
      expr = true,
      desc = 'Jab: f-motion forward',
    },
    {
      'F',
      function()
        return require('jab').F()
      end,
      mode = { 'n', 'x', 'o' },
      expr = true,
      desc = 'Jab: f-motion backward',
    },
    {
      't',
      function()
        return require('jab').t()
      end,
      mode = { 'n', 'x', 'o' },
      expr = true,
      desc = 'Jab: t-motion forward',
    },
    {
      'T',
      function()
        return require('jab').T()
      end,
      mode = { 'n', 'x', 'o' },
      expr = true,
      desc = 'Jab: t-motion backward',
    },
  },
}
