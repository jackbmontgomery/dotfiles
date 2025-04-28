return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    latex = {
      enabled = false,
      --   render_modes = false,
      --   converter = 'latex2text',
      --   highlight = 'RenderMarkdownMath',
      --   position = 'above',
      --   top_pad = 0,
      --   bottom_pad = 0,
    },
  },
}
