return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = 'Jack Montgomery',
        path = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Jack Montgomery/',
      },
    },
    notes_subdir = '0 - Inbox',

    new_notes_location = 'notes_subdir',

    templates = {
      subdir = 'Templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M:%S',
    },
    completion = {
      blink = true,
    },
    footer = {
      enabled = false,
    },
  },
}
