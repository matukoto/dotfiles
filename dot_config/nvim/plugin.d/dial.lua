local set = require('dial.map')
local map = vim.keymap

map.set('n', '<C-a>', function()
  set.manipulate('increment', 'normal')
end)
map.set('n', '<C-x>', function()
  set.manipulate('decrement', 'normal')
end)
