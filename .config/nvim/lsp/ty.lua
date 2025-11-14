return {
  cmd = { 'ty', 'server' },
  filetypes = { 'python' },
  -- these settings are sent to the server by lspconfig
  settings = {
    ty = {
      diagnosticMode = 'workspace',
      disableLanguageServices = true,
    },
  },
  on_attach = function(client, _)
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.definitionProvider = false
    client.server_capabilities.referencesProvider = false
    client.server_capabilities.documentSymbolProvider = false
    client.server_capabilities.codeActionProvider = false
    client.server_capabilities.completionProvider = nil
  end,
}
