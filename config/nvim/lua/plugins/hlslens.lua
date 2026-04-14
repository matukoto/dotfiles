local function keys(key)
  key.noremap = true
  key.silent = true
  key.desc = key[2]
  return key
end
return {
  'kevinhwang91/nvim-hlslens',
  -- Dependencies: Integrates with vim-asterisk
  dependencies = { 'haya14busa/vim-asterisk' },
  -- Load lazily, triggered by search keymaps
  event = 'VeryLazy',
  keys = {
    keys({
      'n',
      [[<Cmd>execute("normal! " . v:count1 . "n")<CR><Cmd>lua require("hlslens").start()<CR>]],
      mode = 'n',
    }),
    keys({
      'N',
      [[<Cmd>execute("normal! " . v:count1 . "N")<CR><Cmd>lua require("hlslens").start()<CR>]],
      mode = 'n',
    }),
    keys({
      '*',
      [[<Plug>(asterisk-z*)<Cmd>lua require("hlslens").start()<CR>]],
      mode = { 'n', 'x' },
    }),
    keys({
      '#',
      [[<Plug>(asterisk-z#)<Cmd>lua require("hlslens").start()<CR>]],
      mode = { 'n', 'x' },
    }),
    keys({
      'g*',
      [[<Plug>(asterisk-g*)<Cmd>lua require("hlslens").start()<CR>]],
      mode = { 'n', 'x' },
    }),
    keys({
      'g#',
      [[<Plug>(asterisk-g#)<Cmd>lua require("hlslens").start()<CR>]],
      mode = { 'n', 'x' },
    }),
  },
  opts = {
    auto_enable = true,
    nearest_only = true,
  },
}
