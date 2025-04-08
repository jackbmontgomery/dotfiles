return {
  {
    'theprimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'

      harpoon:setup()

      vim.keymap.set('n', '<leader>a', function()
        if #harpoon:list().items <= 4 then
          harpoon:list():add()
        else
          vim.notify('Too many files harpooned', vim.log.levels.WARN)
        end
      end)

      vim.keymap.set('n', '<C-h>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set('n', '<leader>1', function()
        harpoon:list():select(1)
      end)

      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end)

      vim.keymap.set('n', '<leader>3', function()
        harpoon:list():select(3)
      end)

      vim.keymap.set('n', '<leader>4', function()
        harpoon:list():select(4)
      end)
    end,
  },
}
