return {
  cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose', '--compile-commands-dir=build' },
  filetypes = { 'c', 'cpp' },
  init_options = {
    fallbackFlags = { '-std=c++17' },
  },
}
