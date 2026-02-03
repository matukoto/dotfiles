---@type vim.lsp.Config
return {
  settings = {
    sqls = {
      connections = {
        {
          driver = 'postgresql',
          -- '%3D' をデコードすると '=', schemaName をスキーマ名に置換すればスキーマ名を指定する必要がなくなる
          dataSourceName = 'postgres://postgres:postgres@localhost:5432/postgres?sslmode=disable&options=-csearch_path%3DschemaName',
        },
      },
    },
  },
}
