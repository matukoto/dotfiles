-- dot_config/nvim/lua/plugins/blink.lua
return {
  'saghen/blink.cmp',
  -- Build step is required for this plugin
  build = 'cargo build --release',
  -- Load when entering insert mode or specific completion events
  event = { "InsertEnter", "CmdlineEnter" },
  -- Dependencies like LSP and snippet engines should be loaded
  dependencies = {
    -- Add snippet engine dependency if used, e.g., 'L3MON4D3/LuaSnip'
    -- 'L3MON4D3/LuaSnip',
    -- 'rafamadriz/friendly-snippets', -- Optional: Snippet collection
  },
  -- opts table passes configuration directly to setup()
  opts = {
    -- enabled = function() ... end, -- Conditional enabling (optional)
    keymap = {
      preset = 'default',
      -- Override default keymaps if needed
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
      ghost_text = { enabled = true }, -- Show inline preview
    },
    sources = {
      -- Default sources: LSP, path, snippets (if available), buffer
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      -- Customize sources per filetype if needed
      -- markdown = { 'buffer', 'path' },
    },
    snippets = {
      preset = 'default', -- Use default snippet integration (requires snippet engine)
    },
    signature = {
      enabled = true, -- Enable signature help
      window = { border = 'solid' },
    },
    fuzzy = {
      implementation = 'lua', -- Use built-in Lua fuzzy matcher
      -- implementation = 'rust', -- Use Rust implementation (requires build)
    },
  },
  -- config function can be used for additional setup after opts are applied
  config = function(_, opts)
    require('blink.cmp').setup(opts)
    -- Example: Add custom source or filetype specific setup
    -- require('blink.cmp').setup_filetype('markdown', {
    --   sources = { default = { 'buffer', 'path' } }
    -- })
  end,
}
