-- dot_config/nvim/lua/plugins/styler.lua
-- Apply different colorschemes to active/inactive windows
return {
  'folke/styler.nvim',
  -- Load lazily, triggered by window events defined in config
  event = 'VeryLazy',
  -- init function runs before the plugin is loaded
  init = function()
    -- Define global colorscheme variables
    -- Ensure these colorschemes are installed (e.g., listed in plugins.lua)
    _G.DEFAULT_COLORSCHEME = 'nekonight-nord' -- Or your preferred default
    _G.INACTIVE_COLORSCHEME = 'nekonight-onedark' -- Or your preferred inactive theme

    -- Set the initial colorscheme
    -- Use pcall for safety in case the colorscheme isn't available immediately
    local ok, _ = pcall(vim.cmd, 'colorscheme ' .. _G.DEFAULT_COLORSCHEME)
    if not ok then
      vim.notify('Failed to set initial colorscheme: ' .. _G.DEFAULT_COLORSCHEME, vim.log.levels.WARN)
    end
  end,
  -- No specific opts needed for default setup
  opts = {},
  -- config function runs after the plugin is loaded
  config = function(_, opts)
    -- styler.nvim doesn't have a setup function, but we define autocmds here
    -- require('styler').setup(opts) -- No setup function exists

    -- Function to apply inactive theme
    local function inactivate(win)
      -- Ensure styler is loaded
      local styler_ok, styler = pcall(require, 'styler')
      if not styler_ok then
        return
      end

      -- Skip invalid or floating windows
      if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_config(win).relative ~= '' then
        return
      end

      -- Apply inactive colorscheme if not already applied
      -- Access window-local theme data safely
      local current_theme = vim.w[win] and vim.w[win].theme
      if not current_theme or current_theme.colorscheme ~= _G.INACTIVE_COLORSCHEME then
        -- Use pcall for safety in case the inactive colorscheme isn't valid
        local ok, _ = pcall(styler.set_theme, win, { colorscheme = _G.INACTIVE_COLORSCHEME })
        if not ok then
          vim.notify('Failed to set inactive colorscheme: ' .. _G.INACTIVE_COLORSCHEME, vim.log.levels.WARN)
        end
      end
    end

    -- Autocommand to manage active/inactive themes
    vim.api.nvim_create_autocmd({ 'WinLeave', 'WinNew' }, {
      group = vim.api.nvim_create_augroup('StylerNvimCustom', { clear = true }),
      callback = function(args)
        local win_event = vim.api.nvim_get_current_win() -- Window where event occurred

        -- Schedule the logic to run after Neovim settles window changes
        vim.schedule(function()
          -- Ensure styler is loaded
          local styler_ok, styler = pcall(require, 'styler')
          if not styler_ok then
            return
          end

          local win_pre = vim.fn.win_getid(vim.fn.winnr('#')) -- Previous window ID
          local win_cursor = vim.api.nvim_get_current_win() -- Current window ID

          -- Clear theme from the newly focused window (restore default)
          -- Access window-local theme data safely
          local cursor_theme = vim.w[win_cursor] and vim.w[win_cursor].theme
          if cursor_theme and cursor_theme.colorscheme then
            pcall(styler.clear, win_cursor)
          end

          -- Inactivate the previous window if it's valid and not the current one
          if win_pre ~= 0 and win_pre ~= win_cursor then
            inactivate(win_pre)
          end

          -- Inactivate the event window if it's valid and not the current one
          -- This handles cases like closing a window (WinLeave fires on the closed win)
          if win_event ~= win_cursor and vim.api.nvim_win_is_valid(win_event) then
            inactivate(win_event)
          end
        end)
      end,
    })
  end,
}
