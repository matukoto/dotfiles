-- dot_config/nvim/lua/plugins/hlchunk.lua
return {
  'shellRaining/hlchunk.nvim',
  -- Load when a buffer is entered or modified
  event = { "BufReadPost", "BufNewFile", "BufEnter" },
  -- opts table passes configuration directly to setup()
  opts = {
    chunk = {
      enable = true,
      notify = false,
      use_treesitter = true,
      -- support_filetypes and exclude_filetypes use defaults unless specified
      chars = {
        horizontal_line = '─',
        vertical_line = '│',
        left_top = '╭',
        left_bottom = '╰',
        right_arrow = '>',
      },
      style = {
        -- Use highlight group names or direct hex codes
        { fg = '#806d9c' }, -- Default chunk color (e.g., HlChunkDefault)
        { fg = '#c21f30' }, -- Error chunk color (e.g., HlChunkError)
        -- You can define more styles if needed
      },
      -- textobject = '', -- Define text object if needed (e.g., 'ic', 'ac')
      max_file_size = 1024 * 1024, -- 1MB
      error_sign = true,
    },
    indent = {
      enable = false, -- Indent guides disabled as per original config
      -- chars = { ... },
      -- style = { ... },
    },
    line_num = {
      enable = false, -- Line number highlighting disabled
      -- style = { ... },
    },
    blank = {
      enable = false, -- Blank line indicators disabled
      -- chars = { ... },
      -- style = { ... },
    },
    -- context = {
    --   enable = false, -- Context display (experimental)
    -- },
  },
  -- No explicit config function needed if opts handles everything
  config = function(_, opts)
    -- Ensure Treesitter is available if use_treesitter is true
    if opts.chunk and opts.chunk.enable and opts.chunk.use_treesitter then
      local ts_ok, _ = pcall(require, 'nvim-treesitter')
      if not ts_ok then
        vim.notify("hlchunk.nvim requires nvim-treesitter when use_treesitter is enabled.", vim.log.levels.WARN)
        opts.chunk.use_treesitter = false -- Fallback if treesitter isn't loaded
      end
    end
    require('hlchunk').setup(opts)
  end,
}
