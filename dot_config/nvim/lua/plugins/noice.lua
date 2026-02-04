return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  opts = {
    presets = {
      command_palette = true,
      bottom_search = false,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
    views = {
      cmdline_popup = {
        position = {
          row = '40%',
          col = '50%',
        },
        size = {
          width = 60,
          height = 'auto',
        },
      },
    },
    routes = {
      {
        -- lsp の progress で特定の情報を非表示にする
        filter = {
          event = 'lsp',
          kind = 'progress',
          any = { { find = 'Validate document' }, { find = 'Publish Diagnostics' }, { find = 'Building' } },
        },
        opts = { skip = true },
      },
    },
    cmdline = {
      view = 'cmdline_popup',
    },
    messages = {
      enabled = true,
      view = 'notify',
    },
    popupmenu = {
      enabled = true,
      backend = 'nui',
    },
    lsp = {
      progress = { enabled = true },
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
    },
  },
}
