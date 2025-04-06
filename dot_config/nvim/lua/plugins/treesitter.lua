-- dot_config/nvim/lua/plugins/treesitter.lua
return {
  {
    'nvim-treesitter/nvim-treesitter',
    -- build step ensures parsers are installed/updated
    event = { 'BufReadPost', 'BufNewFile' },
    build = ':TSUpdate',
    -- opts will be passed to the setup function
    opts = {
      -- A list of parser names, or "all"
      ensure_installed = {
        -- Neovim
        'query',
        'vimdoc',
        'vim',
        'lua',
        'fsharp',
        'make',
        -- Frontend
        'typescript',
        'tsx',
        'javascript',
        'vue',
        'svelte',
        'html',
        'css',
        -- Backend/Other
        'java',
        'groovy',
        'bash',
        'go',
        'sql',
        -- 'nu',
        'markdown',
        'markdown_inline',
        -- Files
        'dot',
        'json',
        'yaml',
        'toml',
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you manage parsers manually with :TSInstall
      auto_install = false, -- Or true if you prefer auto-install

      highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = { 'markdown' },
      },
      indent = {
        enable = true,
        -- disable = { "yaml" }, -- Example: disable indentation for specific languages
      },
      -- Other modules can be configured here, e.g., incremental_selection, refactor, etc.
      -- endwise module configuration (if needed, though often handled by other plugins now)
      -- endwise = {
      --   enable = true,
      -- },
    },
    -- config function runs after the plugin is loaded and opts are processed
    config = function(_, opts)
      -- Call the setup function with the defined options
      require('nvim-treesitter.configs').setup(opts)

      -- Optional: You could add additional setup steps here if needed
      -- print("nvim-treesitter configured")
    end,
  },
  {
    -- Context plugin depends on treesitter
    'nvim-treesitter/nvim-treesitter-context',
    -- opts are passed to the setup function automatically by lazy.nvim
    opts = {
      enable = true, -- Enable this plugin
      max_lines = 0, -- No limit on context lines
      min_window_height = 0, -- No minimum window height limit
      line_numbers = true,
      multiline_threshold = 20, -- Max lines for single context
      trim_scope = 'outer', -- Trim outer context lines if max_lines exceeded
      mode = 'cursor', -- Context based on cursor position
      separator = nil, -- No separator line
      zindex = 20, -- Context window Z-index
      -- on_attach = nil, -- Optional callback
    },
    -- No explicit config needed if opts is sufficient for setup
    -- config = function(_, opts)
    --   require('treesitter-context').setup(opts)
    --   print("treesitter-context configured")
    -- end
  },
}
