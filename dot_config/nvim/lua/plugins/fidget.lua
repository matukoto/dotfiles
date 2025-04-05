-- dot_config/nvim/lua/plugins/fidget.lua
return {
  'j-hui/fidget.nvim',
  -- Load lazily, typically when LSP starts attaching
  event = 'LspAttach',
  -- Basic opts, things requiring the plugin to be loaded are moved to config
  opts = {
    progress = {
      poll_rate = 0, -- Keep basic options here
      suppress_on_insert = false,
      ignore_done_already = false,
      ignore_empty_message = false,
      clear_on_detach = function(client_id)
        local client = vim.lsp.get_client_by_id(client_id)
        return client and client.name or nil
      end,
      notification_group = function(msg)
        return msg.lsp_client.name
      end,
      ignore = {},
      display = { -- Keep basic display options here
        render_limit = 16,
        done_ttl = 3,
        done_icon = '✔',
        done_style = 'Constant',
        progress_ttl = math.huge,
        progress_icon = {
          pattern = 'dots',
          period = 1,
        },
        progress_style = 'WarningMsg',
        group_style = 'Title',
        icon_style = 'Question',
        priority = 30,
        skip_history = true,
        -- format_message requires fidget to be loaded, move to config
        -- format_message = function(...) ... end,
        format_annote = function(msg)
          return msg.title
        end,
        format_group_name = function(group)
          return tostring(group)
        end,
      },
      lsp = {
        progress_ringbuf_size = 0,
        log_handler = false,
      },
    },
    notification = { -- Keep basic notification options here
      poll_rate = 10,
      filter = vim.log.levels.INFO,
      history_size = 128,
      override_vim_notify = false,
      configs = {
        -- default requires fidget to be loaded, move to config
        -- default = require('fidget.notification').default_config,
      },
      -- redirect requires fidget to be loaded, move to config
      -- redirect = function(msg, level, opts) ... end,
      view = { -- Keep basic view options here
        stack_upwards = true,
        icon_separator = ' ',
        group_separator = '---',
        group_separator_hl = 'Comment',
        render_message = function(msg, cnt)
          return cnt == 1 and msg or string.format('(%dx) %s', cnt, msg)
        end,
      },
      window = {
        normal_hl = 'Comment',
        winblend = 100, -- Fully transparent background (adjust as needed)
        border = 'none',
        zindex = 45,
        max_width = 0,
        max_height = 0,
        x_padding = 1,
        y_padding = 0,
        align = 'bottom',
        relative = 'editor',
      },
    },
    -- Integration settings (ensure these plugins are loaded if enabled)
    integration = {
      ['nvim-tree'] = {
        enable = true,
      },
      -- ['xcodebuild-nvim'] = { -- Keep disabled unless xcodebuild-nvim is used
      --   enable = true,
      -- },
    },
    logger = {
      level = vim.log.levels.WARN,
      max_size = 10000,
      float_precision = 0.01,
      path = string.format('%s/fidget.nvim.log', vim.fn.stdpath('cache')),
    },
  },
  -- config function runs after the plugin is loaded
  config = function(_, opts)
    -- Set options that require the plugin to be loaded
    opts.progress.display.format_message = function(...)
      -- Use pcall for safety in case the module path changes in future versions
      local ok, display = pcall(require, 'fidget.progress.display')
      if ok then
        return display.default_format_message(...)
      else
        return '...' -- Fallback message
      end
    end

    local ok_notification, notification = pcall(require, 'fidget.notification')
    if ok_notification then
      opts.notification.configs.default = notification.default_config
      opts.notification.redirect = function(msg, level, notify_opts)
        -- Example: Redirect to nvim-notify if available and on_open is used
        if notify_opts and notify_opts.on_open then
          local ok_integration, integration = pcall(require, 'fidget.integration.nvim-notify')
          if ok_integration then
            return integration.delegate(msg, level, notify_opts)
          end
        end
        -- Default behavior (no redirection)
        return nil
      end
    else
      vim.notify("Failed to require 'fidget.notification'", vim.log.levels.WARN)
    end

    -- Apply the final configuration
    require('fidget').setup(opts)
  end,
}
