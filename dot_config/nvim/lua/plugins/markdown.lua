-- dot_config/nvim/lua/plugins/markdown.lua
-- Configuration for MeanderingProgrammer/markdown.nvim
return {
  'MeanderingProgrammer/markdown.nvim',
  -- Load for markdown filetypes
  ft = { 'markdown' },
  -- Dependencies (ensure treesitter and its markdown parser are installed)
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  -- opts table passes configuration directly to setup()
  -- The original config only called setup(), so using default opts.
  opts = {
    -- Add any specific markdown.nvim options here if needed
    -- Example: Configure code block languages for highlighting
    -- code_blocks = { enable = true, languages = { "python", "lua", "bash" } },
    -- Example: Configure frontmatter highlighting
    -- frontmatter = { enable = true, lang = "yaml" },
  },
  -- config function ensures setup is called after loading
  config = function(_, opts)
    -- Assuming 'render-markdown' was an alias or part of this plugin's setup
    require('markdown').setup(opts)
  end,
}
