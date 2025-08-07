return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      python = {
        'ruff_fix',
        'ruff_format',
        'ruff_organize_imports',
      },
      lua = { 'stylua' },
      rust = { 'rustfmt' },
      json = { 'jq' },
      cpp = { 'clang-format' },
      tex = { 'tex-fmt' },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
  },
}
