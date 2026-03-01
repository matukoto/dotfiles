return {
  'sindrets/diffview.nvim',
  event = 'VeryLazy',
  opts = {
    file_panel = {
      listing_style = 'list', -- One of 'list' or 'tree'
    },
    keymaps = {
      disable_defaults = false,
      file_panel = {
        {
          'n',
          'j',
          function()
            require('diffview.actions').select_next_entry()
          end,
          { desc = 'Open the diff for the next file' },
        },
        {
          'n',
          'k',
          function()
            require('diffview.actions').select_prev_entry()
          end,
          { desc = 'Open the diff for the previous file' },
        },
      },
      file_history_panel = {
        {
          'n',
          'j',
          function()
            require('diffview.actions').select_next_entry()
          end,
          { desc = 'Open the diff for the next file' },
        },
        {
          'n',
          'k',
          function()
            require('diffview.actions').select_prev_entry()
          end,
          { desc = 'Open the diff for the previous file' },
        },
      },
    },
  },
  keys = {
    { '<C-g>d', '<Cmd>DiffviewOpen<CR>', desc = 'Open Diffview' },
  },
}
