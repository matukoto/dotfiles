-- dot_config/nvim/lua/plugins/skkeleton.lua
-- Configuration for vim-skk/skkeleton Japanese input method
return {
  'vim-skk/skkeleton',
  -- Dependencies: Denops is required
  dependencies = { 'vim-denops/denops.vim' },
  -- Load earlier to ensure Denops is ready
  event = { 'BufReadPre', 'BufNewFile', 'InsertEnter', 'CmdlineEnter' },
  -- No specific opts needed, configuration is done via vim.call in config
  -- config function to apply Vim script settings using vim.call and Lua API
  config = function()
    -- Configuration is now expected to run after Denops is ready due to earlier event trigger
    -- Ensure skkeleton functions are available
    if
      vim.fn.exists('*skkeleton#config') ~= 2
      or vim.fn.exists('*skkeleton#register_kanatable') ~= 2
    then
      vim.notify('skkeleton functions not found.', vim.log.levels.WARN)
      return
    end

    -- Main skkeleton configuration
    vim.call('skkeleton#config', {
      globalDictionaries = {
        vim.fn.expand('~/.skk/SKK-JISYO.L'),
        vim.fn.expand('~/.skk/SKK-JISYO.emoji.utf8'),
        vim.fn.expand('~/.skk/SKK-JISYO.geo'),
        vim.fn.expand('~/.skk/SKK-JISYO.jinmei'),
        vim.fn.expand('~/.skk/SKK-JISYO.propernoun'),
      },
      sources = { 'deno_kv', 'google_japanese_input' },
      databasePath = vim.fn.expand('~/.skk/skkeleton.db'),
      eggLikeNewline = false,
      immediatelyCancel = false,
      registerConvertResult = true,
      showCandidatesCount = 2,
      debug = false,
      keepState = false, -- Initial state set here
      userDictionary = vim.fn.expand('~/.skk/userdict.txt'),
    })

    -- Register custom kana table entries
    vim.call('skkeleton#register_kanatable', 'rom', {
      ['--'] = { '-', '' },
      ['-'] = { 'ー', '' },
      ['..'] = { '.', '' },
      ['.'] = { '。', '' },
      [',,'] = { ',', '' },
      ['/'] = { '/', '' },
      ['//'] = { '・', '' },
      ['['] = { '[', '' },
      ['[['] = { '「', '' },
      [']'] = { ']', '' },
      [']]'] = { '」', '' },
    })

    -- Function to ensure keepState is false on enable
    -- Use Lua function instead of Vim script function
    local function skkeleton_init()
      vim.call('skkeleton#config', { keepState = false })
    end

    -- Autocmd to call the init function before skkeleton enables
    vim.api.nvim_create_autocmd('User', {
      pattern = 'skkeleton-enable-pre',
      group = vim.api.nvim_create_augroup('SkkeletonEnablePreviousLua', { clear = true }),
      callback = skkeleton_init,
    })

    -- Keymappings to enable skkeleton
    vim.keymap.set(
      { 'i', 'c' },
      '<C-j>',
      '<Plug>(skkeleton-enable)',
      { noremap = false, desc = 'Enable Skkeleton' }
    )
    -- vim.schedule_wrap removed
  end,
}
