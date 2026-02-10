return {
  {
    event = 'VeryLazy',
    config = function()
      local auto_reload_group = vim.api.nvim_create_augroup('AutoReloadOnExternalChange', { clear = true })

      local function checktime_if_safe()
        if vim.fn.mode() ~= 'c' then
          vim.cmd('silent! checktime')
        end
      end

      vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
        pattern = '*',
        group = auto_reload_group,
        callback = checktime_if_safe,
      })

      local idle_timer = vim.uv.new_timer()

      local function stop_idle_timer()
        if idle_timer and idle_timer:is_active() then
          idle_timer:stop()
        end
      end

      local function start_idle_timer()
        stop_idle_timer()
        idle_timer:start(
          1000,
          1000,
          vim.schedule_wrap(function()
            if vim.fn.mode() ~= 'c' and vim.api.nvim_get_mode().blocking == false then
              vim.api.nvim_exec_autocmds('User', { pattern = 'IdleTick' })
            end
          end)
        )
      end

      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        pattern = '*',
        group = auto_reload_group,
        callback = start_idle_timer,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'InsertEnter', 'InsertLeave', 'CmdlineEnter' }, {
        pattern = '*',
        group = auto_reload_group,
        callback = stop_idle_timer,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'IdleTick',
        group = auto_reload_group,
        callback = checktime_if_safe,
      })

      vim.api.nvim_create_autocmd('VimLeavePre', {
        pattern = '*',
        group = auto_reload_group,
        callback = stop_idle_timer,
      })
    end,
  },
}
