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
      json = { 'dprint' },
      cpp = { 'clang-format' },
      tex = { 'tex-fmt' },
      julia = { 'runic' },
      plaintex = { 'tex-fmt' },
      bib = { 'tex-fmt' },
      markdown = function(bufnr)
        local path = vim.api.nvim_buf_get_name(bufnr)
        if path:match '/%.config/zk/templates' then
          return {}
        end
        return { 'dprint' }
      end,
    },
    formatters = {
      prettier = {
        prepend_args = { '--print-width', '100', '--prose-wrap', 'always' },
      },
    },
    format_on_save = {
      timeout_ms = 10000,
      lsp_format = 'fallback',
    },
  },
}
