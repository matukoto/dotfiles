-- dot_config/nvim/lua/plugins/fidget.lua
return {
  'j-hui/fidget.nvim',
  tag = 'legacy', -- Specify the tag used in the main plugins list
  -- Load lazily, typically when LSP starts attaching
  event = "LspAttach",
  -- opts table passes configuration directly to setup()
  opts = {
    progress = {
      poll_rate = 0,
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
      display = {
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
        -- format_message requires fidget to be loaded, safe within opts
        format_message = function(...)
            return require('fidget.progress.display').default_format_message(...)
        end,
        format_annote = function(msg) return msg.title end,
        format_group_name = function(group) return tostring(group) end,
      },
      lsp = {
        progress_ringbuf_size = 0,
        log_handler = false,
      },
    },
    notification = {
      poll_rate = 10,
      filter = vim.log.levels.INFO,
      history_size = 128,
      override_vim_notify = false, -- Set to true to use fidget for all vim.notify calls
      configs = {
        default = require('fidget.notification').default_config,
        -- update_hook = false, -- This seems incorrect, likely meant for specific configs
      },
      -- redirect requires fidget to be loaded, safe within opts
      redirect = function(msg, level, opts)
        -- Example: Redirect to nvim-notify if available and on_open is used
        if opts and opts.on_open then
           local notify_ok, nvim_notify = pcall(require, 'fidget.integration.nvim-notify')
           if notify_ok then
              return nvim_notify.delegate(msg, level, opts)
           end
        end
        -- Default behavior (no redirection)
        return nil
      end,
      view = {
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
  -- No explicit config function needed if opts handles everything
  -- config = function(_, opts)
  --   require('fidget').setup(opts)
  -- end,
}
