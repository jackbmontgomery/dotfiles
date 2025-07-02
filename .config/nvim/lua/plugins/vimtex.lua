return {
  'lervag/vimtex',
  ft = 'tex',
  config = function()
    vim.g.vimtex_view_method = 'skim'
    vim.g.vimtex_view_skim_sync = 1
    vim.g.vimtex_view_skim_activate = 1

    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_compiler_latexmk = {
      build_dir = '',
      callback = 1,
      continuous = 1,
      executable = 'latexmk',
      options = {
        '-xelatex',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
      },
    }

    vim.g.vimtex_syntax_enabled = 1
    vim.g.vimtex_tex_conceal = 0
    vim.wo.conceallevel = 0
  end,
}
