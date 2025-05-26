return {
  'epwalsh/obsidian.nvim',
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
      ['<leader>ti'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
    },
    completion = {
      nvim_cmp = false,
    },
    ui = {
      checkboxes = {},
      bullets = {},
    },
  },
}
