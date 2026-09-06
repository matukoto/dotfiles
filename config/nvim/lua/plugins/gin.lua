-- dot_config/nvim/lua/plugins/gin.lua
-- Configuration for gin.vim Git interface
return {
  'lambdalisue/vim-gin',
  -- Dependencies: Denops is required
  dependencies = { 'vim-denops/denops.vim' },
  -- Load when needed, triggered by commands or keymaps
  cmd = { 'Gin', 'GinStatus', 'GinLog', 'GinBranch', 'GinDiff', 'GinPatch' },
  event = 'VeryLazy',
  -- init function to set global variables before loading
  init = function()
    -- Apply changes without confirmation
    vim.g.gin_proxy_apply_without_confirm = 1

    local function open_gin_in_float(command)
      local buf = vim.api.nvim_create_buf(false, true)
      local width = math.floor(vim.o.columns * 0.85)
      local height = math.floor(vim.o.lines * 0.85)
      vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        style = 'minimal',
        border = 'rounded',
      })
      vim.cmd(command)
    end

    -- Run a Gin command in a floating window. Gin's default `edit` opener then
    -- replaces only this temporary buffer, leaving the original window intact.
    vim.api.nvim_create_user_command('GinFloat', function(opts)
      open_gin_in_float(opts.args)
    end, { nargs = '+', complete = 'command' })

    -- Alias typo することが多いため
    vim.cmd('cnoreabbrev GIn Gin')
    vim.cmd('cnoreabbrev GIN Gin')

    -- Configure delta for diff view if executable
    if vim.fn.executable('delta') == 1 then
      vim.g.gin_diff_persistent_args = {
        '++processor=delta --diff-highlight --no-gitconfig --color-only',
      }
    end
  end,
  -- Define global keymaps using the 'keys' table
  keys = {
    { '<C-g>s', '<Cmd>GinFloat GinStatus<CR>', desc = 'Gin Status (Float)' },
    { '<C-g>a', '<Cmd>Gin add --all<CR>', desc = 'Gin Add All' },
    { '<C-g>c', '<Cmd>Gin commit --quiet<CR>', desc = 'Gin Commit' },
    { '<C-g>P', '<Cmd>GinPatch ++no-head %<CR>', desc = 'Gin Patch Buffer' },
    { '<C-g>p', '<Cmd>Gin push --quiet<CR>', desc = 'Gin Push' },
    { '<C-g>l', '<Cmd>GinFloat GinLog<CR>', desc = 'Gin Log (Float)' },
    { '<C-g>b', '<Cmd>GinFloat GinBranch --all<CR>', desc = 'Gin Branch (Float)' },
    -- { '<C-g>d', '<Cmd>GinDiff<CR>', desc = 'Gin Diff' },
  },
  -- config function to define autocmds and custom functions after loading
  config = function()
    -- Define custom functions globally or within this scope
    -- Make them global if called directly from autocmds or keymaps outside this config
    _G.MyGinLogSettings = function()
      vim.keymap.set('n', 'if', '<Plug>(gin-action-fixup:instant-fixup)', { buffer = true, silent = true })
      vim.keymap.set('n', 'ir', '<Plug>(gin-action-fixup:instant-reword)', { buffer = true, silent = true })
      vim.keymap.set('n', '<CR>', '<Plug>(gin-action-show:vsplit)', { buffer = true, silent = true })
      vim.opt_local.cursorline = true
    end

    _G.GinCheckoutCurrentFile = function()
      local file = vim.fn.matchstr(vim.fn.getline('.'), '\\v^\\s*[A-Z]+\\s+\\zs\\S+')
      if file ~= '' then
        vim.cmd('Gin checkout -- ' .. vim.fn.fnameescape(file))
      else
        print('No file found on the current line')
      end
    end

    _G.MyGinStatusSettings = function()
      vim.keymap.set('n', 'co', '<Cmd>lua _G.GinCheckoutCurrentFile()<CR>', { buffer = true, silent = true })
    end

    _G.MyGinPatchSettings = function()
      vim.keymap.set('n', 'dp', '<Plug>(gin-diffput)', { buffer = true, silent = true })
      vim.keymap.set('n', 'do', '<Plug>(gin-diffget)', { buffer = true, silent = true })
    end

    -- Define autocmds
    local gin_augroup = vim.api.nvim_create_augroup('MyGinConfig', { clear = true })
    vim.api.nvim_create_autocmd('User', {
      pattern = 'GinComponentPost',
      group = gin_augroup,
      command = 'redrawtabline', -- Redraw tabline after Gin component action
    })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'gin-log',
      group = gin_augroup,
      callback = function()
        vim.schedule(_G.MyGinLogSettings)
      end, -- Schedule to ensure buffer is ready
    })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'gin-status',
      group = gin_augroup,
      callback = function()
        vim.schedule(_G.MyGinStatusSettings)
      end,
    })
    vim.api.nvim_create_autocmd('BufRead', {
      pattern = 'ginedit://*',
      group = gin_augroup,
      callback = function()
        vim.schedule(_G.MyGinPatchSettings)
      end,
    })

    -- Define command abbreviation
    vim.cmd('cabbrev gsc Gin switch -c')
  end,
}
