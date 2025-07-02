vim.api.nvim_create_autocmd('BufReadPre', {
  pattern = 'Home.md',
  group = vim.api.nvim_create_augroup('obsidian-home', { clear = true }),
  callback = function()
    local vault = os.getenv 'OBSIDIAN_VAULT'
    if not vault then
      vim.notify('OBSIDIAN_VAULT not set', vim.log.levels.ERROR)
      return
    end

    local inbox_path = vault .. '/0 - Inbox'
    local projects_path = vault .. '/3 - Projects'
    local courses_path = vault .. '/4 - Courses'
    local reminders_path = vault .. '/Reminders.md'
    local home_file_path = vault .. '/Home.md'
    local output = {}

    table.insert(output, '# Home\n')

    -- Reminders section
    table.insert(output, '## [[Reminders]]')

    local reminders = io.open(reminders_path, 'r')
    if reminders then
      local copy = false
      for line in reminders:lines() do
        if line:match '^# Reminders' then
          copy = true
        elseif copy then
          table.insert(output, line)
        end
      end
      reminders:close()
      table.insert(output, '') -- Empty line
    else
      vim.notify('Could not open Reminders.md', vim.log.levels.WARN)
    end

    local uv = vim.loop

    local function list_dir_markdown(dir, label)
      table.insert(output, '## ' .. label)
      local scandir = uv.fs_scandir(dir)
      if not scandir then
        vim.notify('Could not open ' .. dir, vim.log.levels.ERROR)
        return
      end
      while true do
        local name = uv.fs_scandir_next(scandir)
        if not name then
          break
        end
        if name:match '%.md$' then
          local title = name:gsub('%.md$', '')
          local link = string.format('- [[%s/%s|%s]]', dir:match '[^/]+$', title, title)
          table.insert(output, link)
        end
      end
      table.insert(output, '') -- Empty line
    end

    list_dir_markdown(inbox_path, 'Notes to Process')
    list_dir_markdown(projects_path, 'Projects')
    list_dir_markdown(courses_path, 'Courses')

    local file = io.open(home_file_path, 'w')
    if not file then
      vim.notify('Could not open Home.md for writing', vim.log.levels.ERROR)
      return
    end
    file:write(table.concat(output, '\n'))
    file:close()
  end,
})
