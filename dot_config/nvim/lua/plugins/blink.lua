return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'Xantibody/blink-cmp-skkeleton',
      'vim-skk/skkeleton',
      'vim-denops/denops.vim',
    },
    build = 'cargo build --release',
    -- version = '1.*',
    enabled = true,
    event = { 'VeryLazy' },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'none',
        ['<Space>'] = {}, -- Required: Let skkeleton handle Space
        ['<C-j>'] = { 'select_and_accept', 'fallback' }, -- Select next and accept if no selection
        -- ['<C-s>'] = { 'show', 'show_documentation', 'hide_documentation' },
        -- ['<C-e>'] = { 'hide' },
        -- ['<C-y>'] = { 'select_and_accept' },
        -- ['<Up>'] = { 'select_prev', 'fallback' },
        -- ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
        ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' }, -- Example: Select previous
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' }, -- Example: Select previous
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
            components = {
              -- customize the drawing of kind icons
              kind_icon = {
                text = function(ctx)
                  -- default kind icon
                  local icon = ctx.kind_icon
                  -- if LSP source, check for color derived from documentation
                  if ctx.item.source_name == 'LSP' then
                    local color_item = require('nvim-highlight-colors').format(ctx.item.documentation, { kind = ctx.kind })
                    if color_item and color_item.abbr ~= '' then
                      icon = color_item.abbr
                    end
                  end
                  return icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  -- default highlight group
                  local highlight = 'BlinkCmpKind' .. ctx.kind
                  -- if LSP source, check for color derived from documentation
                  if ctx.item.source_name == 'LSP' then
                    local color_item = require('nvim-highlight-colors').format(ctx.item.documentation, { kind = ctx.kind })
                    if color_item and color_item.abbr_hl_group then
                      highlight = color_item.abbr_hl_group
                    end
                  end
                  return highlight
                end,
              },
            },
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
        default = function(ctx)
          if require('blink-cmp-skkeleton').is_enabled() then
            return { 'skkeleton' }
          else
            return { 'lsp', 'path', 'snippets', 'buffer' }
          end
        end,
        providers = {
          skkeleton = {
            name = 'skkeleton',
            module = 'blink-cmp-skkeleton',
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
