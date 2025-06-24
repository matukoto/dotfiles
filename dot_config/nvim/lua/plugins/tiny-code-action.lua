return {
  'rachartier/tiny-code-action.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'folke/snacks.nvim', opts = { terminal = {} } },
  },
  lazy = true,
  event = 'LspAttach',
  opts = {
    backend = 'delta',
    picker = {
      'snacks',
      -- opts = {
      --   layout = {
      --     preview = true,
      --     layout = {
      --       backdrop = true,
      --       width = 0.9,
      --       min_width = 80,
      --       height = 0.9,
      --       min_height = 3,
      --     },
      --   },
      -- },
    },
    backend_opts = {
      delta = {
        -- Header from delta can be quite large.
        -- You can remove them by setting this to the number of lines to remove
        header_lines_to_remove = 4,

        -- The arguments to pass to delta
        -- If you have a custom configuration file, you can set the path to it like so:
        -- args = {
        --     "--config" .. os.getenv("HOME") .. "/.config/delta/config.yml",
        -- }
        args = {
          '--line-numbers',
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
