-- (Obtain yazi.nvim and its dependencies using your preferred method first)
--
-- Next, map a key to open yazi.nvim

require('yazi').setup({
  keymaps = {
    show_help = '<f1>',
    open_file_in_vertical_split = '<c-v>',
    open_file_in_horizontal_split = '<c-l>',
    open_file_in_tab = '<c-t>',
    grep_in_directory = '<c-s>',
    replace_in_directory = '<c-g>',
    cycle_open_buffers = '<tab>',
    copy_relative_path_to_selected_files = '<c-y>',
    send_to_quickfix_list = '<c-q>',
    change_working_directory = '<c-\\>',
  },
})
vim.keymap.set('n', '<leader>y', function()
  require('yazi').yazi()
end)
