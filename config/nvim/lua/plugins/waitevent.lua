-- dot_config/nvim/lua/plugins/waitevent.lua
-- Wait for events in Neovim, useful for external editor integration
return {
  'notomo/waitevent.nvim',
  -- Load very early as it modifies environment variables
  lazy = false, -- Load immediately on startup
  -- No specific opts needed for default setup
  opts = {},
  -- config function runs after the plugin is loaded
  config = function(_, opts)
    -- Ensure waitevent is loaded before configuring editors
    local waitevent_ok, waitevent = pcall(require, 'waitevent')
    if not waitevent_ok then
      vim.notify('waitevent.nvim not loaded, cannot configure editors.', vim.log.levels.WARN)
      return
    end

    -- Configure GIT_EDITOR
    vim.env.GIT_EDITOR = waitevent.editor({
      open = function(ctx, path)
        vim.cmd.split(path) -- Open in a split
        ctx.lcd() -- Change directory locally for the split
        vim.bo.bufhidden = 'wipe' -- Wipe buffer when hidden
      end,
      -- done_events = { 'BufWritePost', 'BufDelete' }, -- Default events
      -- cancel_events = { 'BufDelete' }, -- Default events
    })

    -- Configure EDITOR (for use in :terminal)
    vim.env.EDITOR = waitevent.editor({
      -- Finish immediately upon opening (no waiting for save/close)
      done_events = {},
      cancel_events = {},
      -- open = function(ctx, path) ... end, -- Default open behavior is fine
    })
  end,
}
