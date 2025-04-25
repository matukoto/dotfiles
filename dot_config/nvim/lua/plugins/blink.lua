-- dot_config/nvim/lua/plugins/blink.lua
return {
  {
    'saghen/blink.compat',
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = '*',
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
  {
    'saghen/blink.cmp',
    dependencies = { 'rinx/cmp-skkeleton' },
    build = 'cargo build --release',
    -- event = { 'InsertEnter', 'CmdlineEnter' },
    event = { 'VeryLazy' },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
        ['<C-j>'] = { 'select_and_accept', 'fallback' }, -- Select next and accept if no selection
        -- ['<C-k>'] = { 'select_prev', 'fallback' }, -- Example: Select previous
        -- ['<Tab>'] = { 'accept', 'fallback' }, -- Example: Accept with Tab
      },
      cmdline = {
        enabled = true, -- Enable command line completion
        -- keymap = { preset = 'default', ... }, -- Customize cmdline keymaps if needed
      },
      completion = {
        keyword = { range = 'full' }, -- Match on full word range
        accept = { auto_brackets = { enabled = true } }, -- Enable auto brackets
        list = { selection = { preselect = true, auto_insert = true } }, -- Preselect and auto-insert
        menu = {
          auto_show = true, -- Show menu automatically
          border = 'rounded',
          draw = {
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', 'kind' },
            },
          },
        },
        documentation = {
          window = { border = 'double' },
          auto_show = true,
          auto_show_delay_ms = 1000, -- Delay before showing docs
        },
        ghost_text = { enabled = false }, -- Show inline preview
      },
      sources = {
        -- Default sources: LSP, path, snippets (if available), buffer
        default = { 'skkeleton', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          skkeleton = {
            name = 'skkeleton',
            module = 'blink.compat.source',
          },
          buffer = {
            opts = {
              -- get all buffers, even ones like neo-tree
              get_bufnrs = vim.api.nvim_list_bufs,
            },
          },
        },
      },
      snippets = {
        preset = 'default', -- Use default snippet integration (requires snippet engine)
      },
      signature = {
        enabled = true, -- Enable signature help
        window = { border = 'solid' },
      },
      fuzzy = {
        implementation = 'prefer_rust_with_warning', -- Use built-in Lua fuzzy matcher
      },
    },
  },
}
