return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      disableLanguageServices = false,
      analysis = {
        typeCheckingMode = 'basic',
        diagnosticMode = 'openFilesOnly',
        useLibraryCodeForTypes = true,
        autoImportCompletions = true,
      },
    },
  },
}
