return {
  cmd = { 'typos-lsp' },
  cmd_env = { RUST_LOG = 'error' },
  init_options = {
    config = '~/.config/typos.toml',
    diagnosticSeverity = 'Error',
  },
}
