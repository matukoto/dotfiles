-- dot_config/nvim/lua/plugins/nvim-ts-autotag.lua
-- Automatically add/rename closing tags based on Treesitter
return {
  'windwp/nvim-ts-autotag',
  -- Dependencies: Needs Treesitter and relevant parsers (html, tsx, etc.)
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  -- Load for relevant filetypes
  ft = {
    'html',
    'javascriptreact',
    'typescriptreact',
    'svelte',
    'vue',
    'tsx',
    'jsx',
    'rescript',
    'xml',
    'php',
    'markdown',
    'astro',
    'glimmer',
    'handlebars',
    'hbs',
  },
  -- opts table passes configuration directly to setup()
  -- Note: Original config had setup({ opts = { ... } }), so we use the inner table.
  opts = {
    -- Enable closing tag functionality
    enable_close = true,
    -- Enable tag renaming functionality
    enable_rename = true,
    -- Enable closing tag on typing '</'
    enable_close_on_slash = false, -- Disabled in original config
    -- Filetypes to disable the plugin for (empty by default)
    -- disabled_filetypes = { "markdown" },
    -- Specific filetype settings (overrides opts)
    -- per_filetype = {
    --   ['html'] = { enable_close = false }
    -- },
  },
  -- config function ensures setup is called after loading
  config = function(_, opts)
    require('nvim-ts-autotag').setup(opts)
  end,
}
