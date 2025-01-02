vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  callback = function()
    local filepath = vim.fn.expand('%:p') -- 現在編集中のファイルパスを取得
    -- .github/workflows/ディレクトリ内のファイルのみLintを実行
    if
      filepath:match('%.github/workflows/.*%.yml$')
      or filepath:match('%.github/workflows/.*%.yaml$')
    then
      require('lint').try_lint('actionlint')
    end
  end,
})
require('lint').linters_by_ft = {
  yaml = { 'actionlint' },
}

require('lint').linters.actionlint = {
  name = 'actionlint',
  cmd = 'actionlint',
  stdin = true,
  args = { '-format', '{{json .}}', '-' },
  ignore_exitcode = true,
  parser = function(output)
    if output == '' then
      return {}
    end
    local decoded = vim.json.decode(output)
    if decoded == nil then
      return {}
    end
    local diagnostics = {}
    for _, item in ipairs(decoded) do
      table.insert(diagnostics, {
        lnum = item.line - 1,
        end_lnum = item.line - 1,
        col = item.column - 1,
        end_col = item.end_column,
        severity = vim.diagnostic.severity.WARN,
        source = 'actionlint: ' .. item.kind,
        message = item.message,
      })
    end
    return diagnostics
  end,
}
