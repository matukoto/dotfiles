return {
  'rachartier/tiny-code-action.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'folke/snacks.nvim', opts = { terminal = {} } },
  },
  lazy = true,
  event = 'LspAttach',
  opts = {
    backend = 'difftastic',
    picker = {
      'snacks',
      opts = {
        layout = {
          preview = true,
        },
      },
    },
    backend_opts = {
      difftastic = {
        header_lines_to_remove = 1,
        args = {
          '--color=always',
          '--display=inline',
          '--syntax-highlight=on',
        },
      },
    },
    signs = {
      quickfix = { '󰁨', { link = 'DiagnosticInfo' } },
      others = { '?', { link = 'DiagnosticWarning' } },
      refactor = { '', { link = 'DiagnosticWarning' } },
      ['refactor.move'] = { '󰪹', { link = 'DiagnosticInfo' } },
      ['refactor.extract'] = { '', { link = 'DiagnosticError' } },
      ['source.organizeImports'] = { '', { link = 'DiagnosticWarning' } },
      ['source.fixAll'] = { '', { link = 'DiagnosticError' } },
      ['source'] = { '', { link = 'DiagnosticError' } },
      ['rename'] = { '󰑕', { link = 'DiagnosticWarning' } },
      ['codeAction'] = { '', { link = 'DiagnosticError' } },
    },
  },
  config = function(_, opts)
    require('tiny-code-action').setup(opts)
    vim.keymap.set('n', 'ga', function()
      require('tiny-code-action').code_action()
    end, { noremap = true, silent = true, desc = 'Tiny Code Action' })
  end,
}
