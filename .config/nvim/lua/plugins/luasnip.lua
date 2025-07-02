return {
  'L3MON4D3/LuaSnip',
  dependencies = { 'rafamadriz/friendly-snippets' }, -- optional

  config = function()
    local ls = require 'luasnip'
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node

    -- Add your custom LaTeX snippet:
    ls.add_snippets('tex', {
      s('beg', {
        t '\\begin{',
        i(1, 'environment'),
        t { '}', '\t' },
        i(2),
        t { '', '\\end{' },
        f(function(args)
          return args[1][1]
        end, { 1 }),
        t '}',
      }),
    })
  end,
}
