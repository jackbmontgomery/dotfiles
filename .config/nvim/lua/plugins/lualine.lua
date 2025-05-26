return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        theme = 'gruvbox',
        section_separators = '',
        component_separators = '',
        icons_enabled = true,
      },
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'lsp_status' },
        lualine_y = { 'filetype' },
        lualine_z = { 'location' },
      },
    }
  end,
}
