-- local config = {
--   cmd = { '~/.local/share/nvim/mason/bin/jdtls' },
--   root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
-- }
--
-- require('jdtls').start_or_attach(config)

vim.keymap.set('n', 'gTM', ":lua require('java').test.run_current_method()<CR>", { silent = true })
vim.keymap.set('n', 'gTC', ":lua require('java').test.run_current_class()<CR>", { silent = true })
vim.keymap.set('n', 'gTV', ":lua require('java').test.view_last_report()<CR>", { silent = true })
