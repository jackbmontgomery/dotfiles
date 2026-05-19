return {
  'Vigemus/iron.nvim',
  config = function()
    local iron = require 'iron.core'
    local view = require 'iron.view'
    local common = require 'iron.fts.common'

    iron.setup {
      config = {
        scratch_repl = true,
        repl_definition = {
          sh = {
            command = { 'zsh' },
          },
          python = {
            command = { 'ipython', '--no-autoindent' },
            format = common.bracketed_paste_python,
            block_dividers = { '# %%', '#%%' },
            env = {
              PYTHON_BASIC_REPL = '1',
              PYTHONSTARTUP = vim.fn.expand '~/.config/python/startup.py',
            },
          },
          julia = {
            command = { 'julia', '--project=.' },
            format = common.bracketed_paste,
            block_dividers = { '# %%', '#%%' },
          },
        },
        repl_filetype = function(bufnr, ft)
          return ft
        end,
        repl_open_cmd = view.right '30%',
      },
      keymaps = {
        toggle_repl = '<space>rr', -- toggles the repl open and closed.
        restart_repl = '<space>rR', -- calls `IronRestart` to restart the repl
        visual_send = '<space>sc',
        send_line = '<space>sl',
        send_code_block = '<space>sb',
        send_code_block_and_move = '<space>sn',
        exit = '<space>rq',
        clear = '<space>rc',
      },
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true,
    }
    vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
    vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')

    vim.keymap.set('n', '<leader>pt', function()
      local line = vim.api.nvim_get_current_line()
      require('iron.core').send(nil, '%timeit ' .. line .. '\n')
    end, { desc = '[p]ython [t]ime' })
  end,
}
