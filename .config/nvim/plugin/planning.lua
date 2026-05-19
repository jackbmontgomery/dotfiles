local notes = vim.env.ZK_NOTEBOOK_DIR or vim.fn.expand '~/notes'
local inbox_path = notes .. '/Inbox.md'

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = notes .. '/*',
  callback = function()
    vim.cmd 'ZkCd'
  end,
})

vim.api.nvim_create_user_command('Inbox', function(opts)
  local timestamp = os.date '%Y-%m-%d'
  local line = '- [' .. timestamp .. '] ' .. opts.args
  vim.fn.writefile({ line }, inbox_path, 'a')
  vim.notify 'Captured to inbox'
end, { nargs = '+' })

vim.keymap.set('n', '<leader>ci', ':Inbox ', { desc = '[c]apture to [i]nbox' })

vim.keymap.set('i', '<C-t>', function()
  local ts = os.date '- [%Y-%m-%d] '
  vim.api.nvim_put({ ts }, 'c', true, true)
end, { desc = 'Insert task with timestamp' })
