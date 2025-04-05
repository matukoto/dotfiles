-- dot_config/nvim/lua/plugins/ufo.lua
-- UFO: Fold provider framework
return {
  'kevinhwang91/nvim-ufo',
  -- Dependencies: Requires promise-async and often nvim-treesitter
  dependencies = {
    'kevinhwang91/promise-async',
    'nvim-treesitter/nvim-treesitter', -- Needed for treesitter provider
  },
  -- Load after Treesitter or when needed
  event = 'VeryLazy',
  -- init function to set folding options early
  init = function()
    -- Set options required for UFO + Treesitter folding
    -- These need to be set early, before filetype plugins or LSP might interfere
    vim.o.foldcolumn = '1' -- Show fold column
    vim.o.foldlevel = 99 -- Start with all folds open
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true -- Enable folding

    -- Set foldexpr and foldtext *after* nvim-treesitter is loaded if possible,
    -- but setting them here ensures they are set. A config function in treesitter
    -- might be a slightly better place, but this works.
    -- Check if nvim_treesitter module is available before setting
    local ts_ok, ts = pcall(require, 'nvim_treesitter')
    if ts_ok then
      vim.o.foldexpr = 'nvim_treesitter.foldexpr()'
      vim.o.foldtext = 'nvim_treesitter.foldtext()'
    else
      -- Fallback or default foldexpr if treesitter isn't loaded (less likely with dependency)
      vim.o.foldexpr = 'vim.fn.nvim_foldexpr()'
    end
    vim.o.foldmethod = 'expr' -- Use expression-based folding
  end,
  -- opts table passes configuration directly to setup()
  opts = {
    -- Select providers: Treesitter first, then indent fallback
    provider_selector = function(bufnr, filetype, buftype)
      return { 'treesitter', 'indent' }
    end,
    -- Configure other UFO options if needed
    -- open_fold_hl_timeout = 150,
    -- close_fold_kinds_for_ft = { "imports", "comment" },
    -- fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate) ... end,
    -- preview = { ... },
  },
  -- Define keymaps using the 'keys' table
  keys = {
    {
      'zR',
      function()
        require('ufo').openAllFolds()
      end,
      desc = 'Open All Folds (UFO)',
    },
    {
      'zM',
      function()
        require('ufo').closeAllFolds()
      end,
      desc = 'Close All Folds (UFO)',
    },
    {
      'zr',
      function()
        require('ufo').openFoldsExceptKinds()
      end,
      desc = 'Open Folds Except Kinds (UFO)',
    },
    {
      'zm',
      function()
        require('ufo').closeFoldsWith(0)
      end, -- closeAllFolds == closeFoldsWith(0)
      desc = 'Close Folds With Level (UFO)',
    },
  },
  -- config function ensures setup is called after loading
  config = function(_, opts)
    require('ufo').setup(opts)
  end,
}
