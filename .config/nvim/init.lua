require 'config.options'
require 'config.keymaps'
if not vim.g.vscode then
  require 'config.lazy'
  require 'config.lsp'
end
