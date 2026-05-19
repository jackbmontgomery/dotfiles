return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local notes = vim.env.ZK_NOTEBOOK_DIR or vim.fn.expand '~/notes'
    local inbox_path = notes .. '/Inbox.md'
    local board_path = notes .. '/Board.md'
    local weekly_dir = notes .. '/Weekly/'
    local daily_dir = notes .. '/Daily Note/'

    local function inbox_stats()
      if vim.fn.filereadable(inbox_path) == 0 then
        return 0, 0
      end
      local lines = vim.fn.readfile(inbox_path)
      local total, stale = 0, 0
      local cutoff = os.time() - (7 * 24 * 3600)
      for _, line in ipairs(lines) do
        if line:match '^%- %[ %]' then
          total = total + 1
          local y, m, d = line:match '%[(%d+)-(%d+)-(%d+)'
          if y then
            local ts = os.time { year = tonumber(y), month = tonumber(m), day = tonumber(d) }
            if ts < cutoff then
              stale = stale + 1
            end
          end
        end
      end
      return total, stale
    end

    local function todays_tasks()
      if vim.fn.filereadable(board_path) == 0 then
        return {}
      end
      local lines = vim.fn.readfile(board_path)
      local today = os.date '%Y-%m-%d'
      local today_pattern = today:gsub('%-', '%%-')
      local tasks = {}
      for _, line in ipairs(lines) do
        if line:match '^%- %[ %]' and line:find(today, 1, true) then
          local text = line:gsub('^%- %[ %] ', ''):gsub('%[' .. today_pattern .. '%] ?', '')
          table.insert(tasks, '    • ' .. vim.trim(text))
        end
      end
      return tasks
    end

    local function build_footer()
      local inbox_total, inbox_stale = inbox_stats()
      local tasks = todays_tasks()

      local footer = {
        '',
        '─────────────────────────────────',
        '  Inbox: ' .. inbox_total .. ' items' .. (inbox_stale > 0 and ('  (' .. inbox_stale .. ' stale ⚠)') or ' ✓'),
      }

      if #tasks > 0 then
        table.insert(footer, '')
        table.insert(footer, '  Today:')
        for _, task in ipairs(tasks) do
          table.insert(footer, task)
        end
      else
        table.insert(footer, '')
        table.insert(footer, '  No tasks scheduled for today')
      end

      table.insert(footer, '')
      return footer
    end

    require('dashboard').setup {
      theme = 'doom',
      config = {
        week_header = {
          enable = true,
        },
        center = {
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'Open Inbox',
            key = 'i',
            action = 'edit ' .. inbox_path,
          },
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'Open Board',
            key = 'b',
            action = 'edit ' .. board_path,
          },
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'Weekly Note',
            key = 'w',
            action = 'edit ' .. weekly_dir .. os.date '%Y-W%V' .. '.md',
          },
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'Daily Note',
            key = 'd',
            action = 'edit ' .. daily_dir .. os.date '%Y-%m-%d' .. '.md',
          },
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'Find File',
            key = 'f',
            action = 'Telescope find_files',
          },
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'Recent Files',
            key = 'r',
            action = 'Telescope oldfiles',
          },
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'Oil File Explorer',
            key = 'o',
            action = 'Oil',
          },
        },
        footer = build_footer(),
      },
    }

    vim.keymap.set('n', '<leader>od', ':Dashboard<CR>', { desc = '[o]pen [d]ashboard' })
  end,
}
