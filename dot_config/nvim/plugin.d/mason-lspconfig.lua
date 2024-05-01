require('mason-lspconfig').setup {
}

require('mason-lspconfig').setup_handlers{
  function(server_name)
    return require('lspconfig')[server_name].setup{}
  end
}
