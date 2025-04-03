-- dot_config/nvim/lua/plugins/lspui.lua
return {
  'jinzhongjia/LspUI.nvim',
  -- Dependencies: Icons are often used
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- Load when LSP attaches or specific commands are used
  event = "LspAttach",
  cmd = {
    "LspUI", "LspUIRename", "LspUICodeAction", "LspUIHover",
    "LspUIDiagnostic", "LspUIDefinition", "LspUITypeDefinition",
    "LspUIDeclaration", "LspUIReference", "LspUIImplementation",
    "LspUIInlayHint",
  },
  -- opts table passes configuration directly to setup()
  opts = {
    -- Rename configuration
    rename = {
      enable = true,
      command_enable = true,
      auto_select = true,
      key_binding = {
        exec = '<CR>',
        quit = '<ESC>',
      },
    },
    -- Lightbulb configuration
    lightbulb = {
      enable = true,
      is_cached = true,
      icon = '💡',
      debounce = 250,
    },
    -- Code Action configuration
    code_action = {
      enable = true,
      command_enable = true,
      gitsigns = true, -- Integrate with gitsigns
      key_binding = {
        exec = '<cr>',
        prev = 'k',
        next = 'j',
        quit = 'q',
      },
    },
    -- Hover configuration
    hover = {
      enable = true,
      command_enable = true,
      key_binding = {
        prev = 'p',
        next = 'n',
        quit = 'q',
      },
    },
    -- Position keybinding configuration (for definition, reference, etc.)
    pos_keybind = {
      main = {
        back = '<leader>l',
        hide_secondary = '<leader>h',
      },
      secondary = {
        jump = 'o',
        jump_split = 'sh',
        jump_vsplit = 'sv',
        jump_tab = 't',
        toggle_fold = '<Cr>',
        next_entry = 'J',
        prev_entry = 'K',
        quit = 'q',
        hide_main = '<leader>h',
        fold_all = 'w',
        expand_all = 'e',
        enter = '<leader>l',
      },
    },
    -- Call Hierarchy configuration
    call_hierarchy = {
      enable = true,
      command_enable = true,
      -- key_binding can be configured here if needed
    },
    -- Signature Help configuration
    signature = {
      enable = false, -- Disabled in original config
      icon = '✨',
      color = { fg = '#FF8C00', bg = nil },
      debounce = 300,
    },
    -- Other LspUI options can be added here if needed
    -- e.g., diagnostic = { ... }, inlay_hint = { ... }
  },
  -- No explicit config function needed if opts handles everything
  -- config = function(_, opts)
  --   require('LspUI').setup(opts)
  -- end,
}
