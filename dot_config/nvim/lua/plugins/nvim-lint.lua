-- dot_config/nvim/lua/plugins/nvim-lint.lua
return {
  'mfussenegger/nvim-lint',
  -- Linting is often triggered on save or buffer load
  event = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
  -- opts table passes configuration directly to the lint module
  opts = {
    -- Define linters per filetype
    linters_by_ft = {
      ghaction = { 'actionlint' },
    },
    -- Configure linting on events (optional, defaults are usually good)
    lint_on_events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
    -- Delay in milliseconds before linting on TextChanged/InsertLeave events
    debounce_time = 150,
    -- Show virtual text for diagnostics (can be noisy)
    show_virtual_text = false,
    -- Highlight line with diagnostics
    highlight_line = true,
  },
  -- config function runs after the plugin is loaded and opts are processed
  config = function(_, opts)
    local lint = require('lint')

    -- Apply the options defined in opts (though nvim-lint doesn't have a setup function)
    -- We directly configure the module tables instead.
    lint.linters_by_ft = opts.linters_by_ft or {}

    -- Define the custom actionlint linter configuration
    lint.linters.actionlint = {
      name = 'actionlint',
      cmd = 'actionlint', -- Ensure actionlint is in PATH
      stdin = true,
      args = { '-format', '{{json .}}', '-' },
      ignore_exitcode = true, -- Don't treat non-zero exit code as an error itself
      parser = function(output)
        if output == '' then
          return {}
        end
        -- Use pcall for safer JSON decoding
        local ok, decoded = pcall(vim.json.decode, output)
        if not ok or decoded == nil then
          vim.notify('nvim-lint: Failed to decode actionlint output: ' .. output, vim.log.levels.WARN)
          return {}
        end

        local diagnostics = {}
        for _, item in ipairs(decoded) do
          -- Ensure necessary fields exist
          if item.line and item.column and item.message then
            table.insert(diagnostics, {
              -- Adjust line/col numbers (often 1-based vs 0-based)
              lnum = item.line - 1,
              end_lnum = (item.end_line or item.line) - 1, -- Handle optional end_line
              col = item.column - 1,
              end_col = item.end_column, -- Use end_column if available
              severity = vim.diagnostic.severity.WARN, -- Or map based on item.kind/level
              source = 'actionlint' .. (item.kind and (': ' .. item.kind) or ''),
              message = item.message,
              code = item.kind, -- Use kind as the diagnostic code
            })
          end
        end
        return diagnostics
      end,
    }

    -- Autocmd to trigger linting on specified events
    vim.api.nvim_create_autocmd(opts.lint_on_events or { 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
      callback = function(event)
        -- Use a timer to debounce linting for relevant events
        if event.event == 'InsertLeave' or event.event == 'TextChanged' then
          vim.defer_fn(function()
            lint.try_lint()
          end, opts.debounce_time or 150)
        else
          lint.try_lint()
        end
      end,
    })

    -- Optional: Add a command to manually trigger linting
    vim.api.nvim_create_user_command('Lint', function()
      lint.try_lint()
    end, {})
  end,
}
