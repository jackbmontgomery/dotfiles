vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    map('gr', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  end,
})

vim.keymap.del('n', 'grn') -- Normal mode: rename
vim.keymap.del('n', 'gra') -- Normal mode: code action
vim.keymap.del('v', 'gra') -- Visual mode: code action
vim.keymap.del('n', 'grr') -- Normal mode: references
vim.keymap.del('n', 'gri') -- Normal mode: implementation
vim.keymap.del('n', 'gO') -- Normal mode: document symbol
vim.keymap.del('i', '<C-S>') -- Insert mode: signature help

-- This is copied straight from blink
-- https://cmp.saghen.dev/installation#merging-lsp-capabilities
local capabilities = {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
}

capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

vim.lsp.config('*', {
  capabilities = capabilities,
  root_markers = { '.git' },
})

vim.lsp.enable { 'luals', 'basedpyright', 'rust_analyzer', 'julials' }
