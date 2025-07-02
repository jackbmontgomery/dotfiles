return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = { 'lua', 'markdown', 'julia', 'python', 'rust', 'gitcommit', 'cpp' },
      auto_install = true,
      highlight = {
        enable = true,
        disable = { 'latex', 'bibtex' },
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },
}
