return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.git').setup()
      require('mini.pairs').setup()
      require('mini.comment').setup()
      require('mini.icons').setup()
    end,
  },
}
