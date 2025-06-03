return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'Jack Montgomery',
        path = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Jack Montgomery/',
      },
    },
    notes_subdir = '0 - Inbox',

    new_notes_location = 'notes_subdir',

    disable_frontmatter = true,

    templates = {
      subdir = 'Templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M:%S',
    },

    mappings = {
      ['gf'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ['<leader>tc'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { desc = '[T]oggle [C]heckbox', buffer = true },
      },
      ['<cr>'] = {
        action = function()
          return require('obsidian').util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
      ['<leader>ot'] = {
        action = '<cmd>ObsidianTemplate<cr>',
        opts = { desc = '[O]bsidian [T]emplate' },
      },
    },
    completion = {
      blink = true,
    },
    ui = {
      checkboxes = {},
      bullets = {},
    },
  },
}
