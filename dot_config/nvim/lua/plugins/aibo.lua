return {
  'lambdalisue/nvim-aibo',
  opts = {
    console = {
      mappings = function(bufnr)
        vim.keymap.set({ 'n', 'i' }, '<CR>', '<Plug>(aibo-submit)', { buffer = bufnr, desc = 'Submit to Aibo' })
      end,
    },
    prompt = {
      on_attach = function(bufnr)
        vim.keymap.set({ 'n', 'i' }, '<Tab>', '<Plug>(aibo-send)<Tab>', { buffer = bufnr, desc = 'Send Tab to Aibo' })
        vim.keymap.set({ 'n', 'i' }, '<C-n>', '<Plug>(aibo-send)<Down>', { buffer = bufnr, desc = 'Send Down to Aibo' })
        vim.keymap.set({ 'n', 'i' }, '<C-p>', '<Plug>(aibo-send)<Up>', { buffer = bufnr, desc = 'Send Up to Aibo' })
        vim.keymap.set({ 'n', 'i' }, '<C-c>', '<Plug>(aibo-send)<Esc>', { buffer = bufnr, desc = 'Send Up to Aibo' })
      end,
    },
    keys = {
      vim.keymap.set('n', '<leader>at', ':Aibo -opener=tabnew opencode --continue<CR>', { desc = 'Aibo opencode in Tab' }),
      vim.keymap.set('n', '<leader>av', ':Aibo -opener=vsplit opencode --continue<CR>', { desc = 'Aibo opencode in Vsplit' }),
      --選択範囲を Aibo に送信
      vim.keymap.set('v', '<leader>as', ':AiboSend -submit<CR>', { desc = 'Send selection to Aibo' }),
    },
  },
}
