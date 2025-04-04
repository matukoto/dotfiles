-- dot_config/nvim/lua/plugins/ddc.lua
-- Configuration for ddc.vim and related plugins
return {
  -- Main ddc plugin
  'shougo/ddc.vim',
  -- Dependencies: Denops, UI (pum), sources (skkeleton)
  dependencies = {
    'vim-denops/denops.vim',
    'shougo/pum.vim', -- UI for ddc
    'vim-skk/skkeleton', -- Source for Japanese input
    -- Add other sources/filters/sorters here if uncommented in the original config
    -- 'shougo/ddc-ui-pum', -- Already listed as dependency for pum? Check ddc docs.
    -- 'shougo/ddc-source-lsp',
    -- 'shougo/ddc-source-around',
    -- ... etc
  },
  -- Load earlier to ensure Denops is ready
  event = { 'BufReadPre', 'BufNewFile', 'InsertEnter', 'CmdlineEnter' },
  -- init = function()
  -- Optional: Set global variables if needed before loading
  -- end,
  -- config function to apply Vim script settings using vim.call
  config = function()
    -- Configuration is now expected to run after Denops is ready due to earlier event trigger
    -- Ensure ddc is loaded before patching
    local ddc_ok, ddc = pcall(require, 'ddc')
    if not ddc_ok then
      -- ddc might not expose a Lua module, use vim.fn.exists instead
      if vim.fn.exists('*ddc#custom#patch_global') ~= 2 then
        vim.notify('ddc.vim functions not found.', vim.log.levels.WARN)
        return
      end
    end

    -- Set UI to pum
    vim.call('ddc#custom#patch_global', 'ui', 'pum')

    -- Set sources (only skkeleton enabled in original active config)
    vim.call('ddc#custom#patch_global', 'sources', { 'skkeleton' })
    -- Original commented sources:
    -- vim.call('ddc#custom#patch_global', 'sources', {'skkeleton', 'file', 'around', 'buffer', 'lsp', 'cmdline', 'cmdline_history'})

    -- Configure skkeleton source options
    vim.call('ddc#custom#patch_global', 'sourceOptions', {
      skkeleton = {
        mark = 'skk',
        isVolatile = true,
        matchers = {}, -- Use global matchers/sorters if defined, else empty
        sorters = {},
        converters = {},
        minAutoCompleteLength = 1,
      },
      -- Add configurations for other sources here if they were enabled
      -- Example for lsp (if uncommented):
      -- lsp = {
      --   mark = 'lsp',
      --   isVolatile = true,
      --   forceCompletionPattern = '\\.\\w*|:\\w*|->\\w*',
      --   minAutoCompleteLength = 2,
      -- },
      -- Example for buffer (if uncommented):
      -- buffer = { mark = 'B' },
      -- Example for file (if uncommented):
      -- file = {
      --   mark = 'F',
      --   isVolatile = true,
      --   forceCompletionPattern = '\\S/\\S*',
      --   minAutoCompleteLength = 1,
      -- },
      -- ... and so on for other sources
    })

    -- Configure source parameters (only buffer params were defined, but commented out)
    -- vim.call('ddc#custom#patch_global', 'sourceParams', {
    --   buffer = {
    --     requireSameFiletype = false,
    --     limitBytes = 5000000,
    --     fromAltBuf = true,
    --     forceCollect = true,
    --   },
    --   -- Example for LSP snippet engine (if uncommented)
    --   -- lsp = {
    --   --   snippetEngine = vim.fn['denops#callback#register'](function(body)
    --   --     -- Replace with your snippet engine call, e.g., luasnip
    --   --     -- require('luasnip').lsp_expand(body)
    --   --     vim.fn['vsnip#anonymous'](body) -- Original vsnip call
    --   --   end),
    --   --   enableResolveItem = true,
    --   --   enableAdditionalTextEdit = true,
    --   -- }
    -- })

    -- Configure global defaults for matchers, sorters, converters (commented out in original)
    -- vim.call('ddc#custom#patch_global', 'sourceOptions', {
    --   _ = {
    --     matchers = {'matcher_fuzzy'},
    --     sorters = {'sorter_fuzzy'},
    --     converters = {'converter_remove_overlap'},
    --     maxItems = 50,
    --   }
    -- })

    -- Enable ddc
    vim.call('ddc#enable')

    -- Keymappings for pum.vim UI
    -- Use vim.keymap.set for Lua keymapping
    vim.keymap.set(
      'i',
      '<C-n>',
      '<Cmd>call pum#map#insert_relative(+1)<CR>',
      { noremap = true, silent = true, expr = false }
    )
    vim.keymap.set(
      'i',
      '<C-p>',
      '<Cmd>call pum#map#insert_relative(-1)<CR>',
      { noremap = true, silent = true, expr = false }
    )
    vim.keymap.set(
      'i',
      '<C-y>',
      '<Cmd>call pum#map#confirm()<CR>',
      { noremap = true, silent = true, expr = false }
    )
    vim.keymap.set(
      'i',
      '<C-e>',
      '<Cmd>call pum#map#cancel()<CR>',
      { noremap = true, silent = true, expr = false }
    )

    -- Command line completion setup (commented out in original, keep commented)
    -- This would require translating the CommandlinePre/Post functions and autocmds to Lua
    -- vim.call('ddc#custom#patch_global', {
    --   ui = 'pum',
    --   autoCompleteEvents = { 'InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineChanged' },
    --   cmdlineSources = { [':'] = {'cmdline', 'cmdline_history', 'around'} },
    -- })
    -- vim.keymap.set('n', ';', "<Cmd>call CommandlinePre()<CR>:", { noremap = true })
    -- -- Define CommandlinePre and CommandlinePost in Lua if needed
    -- vim.schedule_wrap removed
  end,
}
