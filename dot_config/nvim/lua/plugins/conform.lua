local jsFormatter = function()
  local root_patterns = {
    biome = { 'biome.json', 'biome.jsonc' },
    eslint = { 'eslint.config.js' },
    prettier = { '.prettierrc', '.prettierrc.json', '.prettierrc.js' },
  }

  local root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'package.json' }, { upward = true })[1])
  if not root_dir then
    root_dir = vim.fn.getcwd()
  end
  for _, pattern in ipairs(root_patterns.biome) do
    if vim.fn.filereadable(root_dir .. '/' .. pattern) == 1 then
      return { 'biome', stop_after_first = true }
    end
  end

  for _, pattern in ipairs(root_patterns.eslint) do
    if vim.fn.filereadable(root_dir .. '/' .. pattern) == 1 then
      return { 'eslint_d', stop_after_first = true }
    end
  end

  for _, pattern in ipairs(root_patterns.prettier) do
    if vim.fn.filereadable(root_dir .. '/' .. pattern) == 1 then
      return { 'prettierd', stop_after_first = true }
    end
  end
  return { 'prettierd', stop_after_first = true }
end

local tsFormatter = function(bufnr) -- Pass bufnr for context
  -- Use vim.fs.find instead of vim.fs.root for better root detection flexibility
  local pkg_json_path =
    vim.fs.find('package.json', { upward = true, path = vim.api.nvim_buf_get_name(bufnr), stop = vim.loop.os_homedir() })
  if pkg_json_path and #pkg_json_path > 0 then
    -- print("Using Node formatter (biome/prettierd/prettier) for:", vim.api.nvim_buf_get_name(bufnr))
    return jsFormatter()
  else
    -- print("Using Deno formatter (deno_fmt) for:", vim.api.nvim_buf_get_name(bufnr))
    return { 'deno_fmt', stop_after_first = true }
  end
end

return {
  'stevearc/conform.nvim',
  -- Load lazily, formatting is often triggered on save or manually
  event = { 'BufWritePre' }, -- Trigger load right before saving
  -- Or use 'VeryLazy' and rely on keymaps/commands
  -- event = "VeryLazy",
  cmd = 'ConformInfo', -- Load when ConformInfo command is used
  opts = {
    -- Define formatters and their configurations
    formatters = {
      pnpm_format = {
        command = 'pnpm',
        args = { 'run', 'format:file', '$FILENAME' },
        stdin = false, -- format コマンドがファイルを直接書き換える場合は false
      },
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      sql = { 'sql_formatter' },
      yaml = { 'yamlfmt' },
      java = { lsp_format = 'fallback' }, -- Use LSP if no other formatter is found
      sh = { 'shellcheck', 'shfmt', stop_after_first = false },
      -- JSON files use the dynamic tsFormatter
      json = { 'fixjson' },
      jsonc = { 'eslint_d' },
      json5 = { 'eslint_d' },
      toml = { 'taplo' },
      -- Frontend files
      svelte = jsFormatter, -- Or jsFormatter if preferred
      fsharp = { 'fantomas' },
      html = jsFormatter,
      css = jsFormatter,
      javascript = jsFormatter,
      javascriptreact = jsFormatter,
      typescript = tsFormatter,
      typescriptreact = tsFormatter,
      go = { 'gofmt' },
      -- Markdown formatting
      markdown = {
        'injected', -- Format code blocks inside markdown
        'typos', -- Fix typos (can be aggressive)
        'markdownlint-cli2', -- Lint markdown
        stop_after_first = false,
      },
      -- Optional: Global fallback or specific formatters
      -- ['*'] = { 'typos' }, -- Be careful with global formatters like typos
    },

    -- Configure format-on-save
    format_on_save = function(buf)
      -- w! で保存したときはフォーマットをスキップ
      if vim.v.cmdbang == 1 then
        return nil
      end
      return {}
    end,

    -- Recommended: Use format_after_save for asynchronous formatting
    -- format_after_save = {
    --   lsp_fallback = true, -- Fallback to LSP if conform fails
    --   async = true,
    --   timeout_ms = 3000, -- Adjust timeout as needed
    --   quiet = true, -- Show messages during formatting
    --   -- stop_after_first = false, -- Run all formatters even if one fails (handled by formatter definition now)
    -- },

    -- Default options for formatters
    default_format_opts = {
      lsp_format = 'never', -- Don't use LSP formatting by default (prefer conform)
      -- timeout_ms = 3000, -- Default timeout for formatters
    },

    -- Optional: Define custom formatters if needed
    -- formatters = {
    --   my_custom_formatter = { ... }
    -- }

    -- Log level for debugging
    log_level = vim.log.levels.WARN, -- Or ERROR, INFO, DEBUG

    -- Notify on error
    notify_on_error = true,
  },
  -- Define keymaps using the 'keys' table
  keys = {
    {
      '<leader>cf', -- Keymap for manual formatting
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      mode = { 'n', 'v' }, -- Normal and Visual mode
      desc = 'Format buffer',
    },
  },
  -- No explicit config function needed if opts and keys are sufficient
  -- config = function(_, opts)
  --   require("conform").setup(opts)
  --   -- Keymaps could also be defined here
  -- end,
}
