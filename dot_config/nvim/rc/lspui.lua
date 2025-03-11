--- @type LspUI_rename_config
local default_rename_config = {
  enable = true,
  command_enable = true,
  auto_select = true,
  key_binding = {
    exec = '<CR>',
    quit = '<ESC>',
  },
}

--- @type LspUI_lightbulb_config
local default_lightbulb_config = {
  enable = true,
  -- whether cache code action, if do, code action will use lightbulb's cache
  is_cached = true,
  icon = '💡',
  debounce = 250,
}

--- @type LspUI_code_action_config
local default_code_action_config = {
  enable = true,
  command_enable = true,
  gitsigns = true,
  key_binding = {
    exec = '<cr>',
    prev = 'k',
    next = 'j',
    quit = 'q',
  },
}

--- @type LspUI_hover_config
local default_hover_config = {
  enable = true,
  command_enable = true,
  key_binding = {
    prev = 'p',
    next = 'n',
    quit = 'q',
  },
}

--- @type LspUI_pos_keybind_config
local default_pos_keybind_config = {
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
}

--- @type LspUI_pos_config
local default_pos_config = {
  main_keybind = {
    back = '<leader>l',
    hide_secondary = '<leader>h',
  },
  secondary_keybind = {
    jump = 'o',
    jump_split = 'sh',
    jump_vsplit = 'sv',
    jump_tab = 't',
    quit = 'q',
    hide_main = '<leader>h',
    fold_all = 'w',
    expand_all = 'e',
    enter = '<leader>l',
  },
}

--- @type LspUI_call_hierarchy_config
local default_call_hierarchy_config = {
  enable = true,
  command_enable = true,
}

--- @type LspUI_signature
local default_signature_config = {
  enable = false,
  icon = '✨',
  color = {
    fg = '#FF8C00',
    bg = nil,
  },
  debounce = 300,
}

require('LspUI').setup({

  rename = default_rename_config,
  lightbulb = default_lightbulb_config,
  code_action = default_code_action_config,
  hover = default_hover_config,
  pos_keybind = default_pos_keybind_config,
  call_hierarchy = default_call_hierarchy_config,
  signature = default_signature_config,
})
-- LspUI hover: Open an LSP hover window above cursor
-- LspUI rename: Rename the symbol below the cursor
-- LspUI code_action: Open a code action selection prompt
-- LspUI diagnostic next: Go to the next diagnostic
-- LspUI diagnostic prev: Go to the previous diagnostic
-- LspUI definition: Open the definition
-- LspUI type_definition: Open the type definition
-- LspUI declaration: Open the declaration
-- LspUI reference: Open the reference
-- LspUI implementation: Open the implementation
-- LspUI inlay_hint: Quickly open or close inlay hint
