return {
  'stevearc/overseer.nvim',
  event = 'VeryLazy',
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  opts = {
    task_list = {
      direction = 'bottom',
      max_height = { 80, 0.6 },
      min_height = { 10, 0.1 },
    },
    keymaps = {
      ['?'] = 'keymap.show_help',
      ['g?'] = 'keymap.show_help',
      ['<CR>'] = 'keymap.run_action',
      ['dd'] = { 'keymap.run_action', opts = { action = 'dispose' }, desc = 'Dispose task' },
      ['<C-e>'] = { 'keymap.run_action', opts = { action = 'edit' }, desc = 'Edit task' },
      ['o'] = 'keymap.open',
      ['<C-v>'] = { 'keymap.open', opts = { dir = 'vsplit' }, desc = 'Open task output in vsplit' },
      ['<C-s>'] = { 'keymap.open', opts = { dir = 'split' }, desc = 'Open task output in split' },
      ['<C-t>'] = { 'keymap.open', opts = { dir = 'tab' }, desc = 'Open task output in tab' },
      ['<C-f>'] = { 'keymap.open', opts = { dir = 'float' }, desc = 'Open task output in float' },
      ['<C-q>'] = {
        'keymap.run_action',
        opts = { action = 'open output in quickfix' },
        desc = 'Open task output in the quickfix',
      },
      ['p'] = 'keymap.toggle_preview',
      ['{'] = 'keymap.prev_task',
      ['}'] = 'keymap.next_task',
      ['<C-k>'] = 'keymap.scroll_output_up',
      ['<C-j>'] = 'keymap.scroll_output_down',
      ['g.'] = 'keymap.toggle_show_wrapped',
      ['q'] = { '<CMD>close<CR>', desc = 'Close task list' },
    },
  },
  key = {
    vim.keymap.set('n', '<Leader>r', '<cmd>OverseerRun<CR>', { desc = 'OverseerRun' }),
    vim.keymap.set('n', '<Leader>R', '<cmd>OverseerToggle<CR>', { desc = 'OverseerToggle' }),
  },
}
