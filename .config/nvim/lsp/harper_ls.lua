return {
  cmd = { 'harper-ls', '--stdio' },
  filetypes = { 'markdown', 'text', 'gitcommit', 'tex', 'typst' },
  settings = {
    ['harper-ls'] = {
      userDictPath = '',
      linters = {
        SpellCheck = true,
        SentenceCapitalization = true,
        LongSentences = true,
        RepeatedWords = true,
        Spaces = true,
      },
      diagnosticSeverity = 'hint',
      dialect = 'British',
      maxFileLength = 120000,
    },
  },
}
