return {
  'atusy/treemonkey.nvim',
  event = 'VeryLazy',
  keys = {
    {
      'm',
      function()
        require('treemonkey').select({
          ignore_injections = false,
        })
      end,
      mode = { 'x', 'o' },
      desc = 'treemonkey: select block',
    },
  },
}
