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

local tsFormatter = function(bufnr)
  local pkg_json_path =
    vim.fs.find('package.json', { upward = true, path = vim.api.nvim_buf_get_name(bufnr), stop = vim.loop.os_homedir() })
  if pkg_json_path and #pkg_json_path > 0 then
    return jsFormatter()
  else
    return { 'deno_fmt', stop_after_first = true }
  end
end

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = 'ConformInfo',
  opts = {
    formatters = {
      injected = {
        options = {
          lang_to_formatters = {
            -- injected yaml に 空を渡すことで markdown でyaml がフォーマットされないようにする
            -- markdown の metaデータ部分が yaml だと認識されてフォーマットされるのを防ぐため
            yaml = {},
          },
        },
      },
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      sql = { 'sql_formatter' },
      yaml = { 'yamlfmt' },
      java = { lsp_format = 'fallback' },
      sh = { 'shellcheck', 'shfmt', stop_after_first = false },
      fish = { 'fish_indent' },
      json = { 'fixjson' },
      jsonc = { 'biome' },
      json5 = { 'fixjson' },
      svelte = tsFormatter,
      fsharp = { 'fantomas' },
      html = jsFormatter,
      css = jsFormatter,
      javascript = jsFormatter,
      javascriptreact = jsFormatter,
      typescript = tsFormatter,
      typescriptreact = tsFormatter,
      go = { 'gofmt' },
      markdown = {
        'injected', -- Format code blocks inside markdown
        'typos', -- Fix typos (can be aggressive)
        'markdownlint-cli2', -- Lint markdown
        stop_after_first = false,
      },
      toml = { 'taplo' },
      -- ['*'] = { 'typos' }, -- Be careful with global formatters like typos
    },

    -- w! で保存したときはフォーマットをスキップ
    format_on_save = function()
      if vim.v.cmdbang == 1 then
        return nil
      end
      return {}
    end,

    default_format_opts = {
      lsp_format = 'never',
    },

    log_level = vim.log.levels.INFO,

    notify_on_error = true,
  },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      mode = { 'n', 'v' },
      desc = 'Format buffer',
    },
  },
}
