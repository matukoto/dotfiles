-- dot_config/nvim/lua/plugins/which-key.lua
return {
  'folke/which-key.nvim',
  event = 'VeryLazy', -- Load on demand when a key is pressed
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    plugins = { spelling = true }, -- Enable spelling suggestions
    triggers = 'auto', -- Automatically show hints
    -- triggers = {"<leader>", "g"}, -- Specify trigger keys
    -- window = { border = "rounded" }, -- Example: customize window border
    notify = false, -- Disable notifications (as per original config)
  },
  config = function(_, opts)
    -- Call setup with the options defined in opts
    require('which-key').setup(opts)

    -- Register key mappings for which-key to display
    -- IMPORTANT: This registers the mappings *for display* in which-key.
    -- The actual keybindings should ideally be defined elsewhere (e.g., using lazy.nvim's `keys` table or in the respective plugin's config).
    -- However, registering them here ensures they appear in the which-key popup.
    require('which-key').register({
      -- LSP Mappings (assuming these are defined in lspconfig.lua or similar)
      g = {
        name = '+LSP', -- Group name starting with '+' is common practice
        d = { '<cmd>lua vim.lsp.buf.definition()<CR>', 'Definition' },
        D = { '<cmd>vsplit lua vim.lsp.buf.definition()<CR>', 'Definition (Split)' },
        l = { vim.lsp.buf.implementation, 'Implementation' },
        L = { '<cmd>Lspsaga peek_definition<CR>', 'Peek Definition' }, -- Requires lspsaga
        t = { '<cmd>Lspsaga peek_type_definition<CR>', 'Peek Type Definition' }, -- Requires lspsaga
        f = { '<cmd>Lspsaga finder ref<CR>', 'Find References' }, -- Requires lspsaga
        r = { '<cmd>Lspsaga rename<CR>', 'Rename' }, -- Requires lspsaga
        a = { '<cmd>Lspsaga code_action<CR>', 'Code Action' }, -- Requires lspsaga
        b = { '<cmd>Lspsaga show_buf_diagnostics<CR>', 'Buffer Diagnostics' }, -- Requires lspsaga
        w = { '<cmd>Lspsaga show_workspace_diagnostics<CR>', 'Workspace Diagnostics' }, -- Requires lspsaga
        e = { vim.diagnostic.open_float, 'Diagnostic Float' },
        q = { vim.diagnostic.setqflist, 'Diagnostic Quickfix' },
        ['['] = { '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Prev Diagnostic' }, -- Requires lspsaga (Note: original had next/prev swapped?)
        [']'] = { '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Next Diagnostic' }, -- Requires lspsaga
      },
      -- Gin Mappings (assuming these are defined elsewhere, e.g., gin plugin config)
      ['<C-g>'] = {
        name = '+Git (Gin)',
        s = { ':GinStatus<CR>', 'Status' }, -- Use :Command<CR> format for commands
        a = { ':Gin add --all<CR>', 'Add All' },
        c = { ':Gin commit --quiet<CR>', 'Commit' },
        P = { ':GinPatch ++opener=tabnew ++no-head %<CR>', 'Patch (Tab)' },
        p = { ':Gin push --quiet<CR>', 'Push' },
        l = { ':GinLog ++opener=tabnew<CR>', 'Log (Tab)' },
        b = { ':GinBranch --all<CR>', 'Branches' },
        d = { ':GinDiff<CR>', 'Diff' },
      },
      -- Leader mappings can also be registered here
      ['<leader>'] = {
        -- Example: Add mappings defined in telescope.lua here for display
        g = { ':Telescope live_grep<CR>', 'Grep' },
        f = { ':Telescope find_files<CR>', 'Find File' },
        o = { ':Telescope smart_open<CR>', 'Smart Open' },
        b = { ':Telescope buffers<CR>', 'Buffers' },
        h = { ':Telescope help_tags<CR>', 'Help Tags' },
        u = { '<cmd>ToggleTerm<CR>', 'Terminal' }, -- From toggleterm.lua
        R = { '<cmd>Telescope repo list<CR>', 'Repo List' },
        r = { '<cmd>Telescope registers<CR>', 'Registers' },
        -- Add other leader mappings...
        z = {
          name = '+Zk',
          k = { '<cmd>Telescope zk notes<CR>', 'Notes' },
          d = { '<cmd>Telescope zk notes createdAfter=3 days ago<CR>', 'Recent Notes' },
          t = { '<cmd>Telescope zk tags<CR>', 'Tags' },
        },
      },
      -- Add other prefixes like ']' or '[' if needed
    })
  end,
}
