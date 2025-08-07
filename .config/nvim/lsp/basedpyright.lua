return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      disableLanguageServices = false,
      analysis = {
        ignore = { '*' },
        -- typeCheckingMode = 'standard',
        -- diagnosticMode = 'openFilesOnly',
        -- useLibraryCodeForTypes = true,
        -- autoImportCompletions = true,
      },
    },
  },
}
