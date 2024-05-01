require('mason-lspconfig').setup {
}

local capabilities = require('ddc_source_lsp').make_client_capabilities()

require('mason-lspconfig').setup_handlers{
  function(server_name)
    return require('lspconfig')[server_name].setup{
    capabilities = capabilities,
  }
  end
}
