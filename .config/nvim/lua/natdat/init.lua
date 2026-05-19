--- @module 'blink.cmp'
--- @class blink.cmp.Source
local source = {}

local DAYS = {
  sunday = 1,
  monday = 2,
  tuesday = 3,
  wednesday = 4,
  thursday = 5,
  friday = 6,
  saturday = 7,
}
local DAY_NAMES = {
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
}
local MONTHS = {
  jan = 1,
  january = 1,
  feb = 2,
  february = 2,
  mar = 3,
  march = 3,
  apr = 4,
  april = 4,
  may = 5,
  jun = 6,
  june = 6,
  jul = 7,
  july = 7,
  aug = 8,
  august = 8,
  sep = 9,
  september = 9,
  oct = 10,
  october = 10,
  nov = 11,
  november = 11,
  dec = 12,
  december = 12,
}

-- seconds-in-a-day, safe for DST if we normalize to noon
local DAY = 24 * 60 * 60

local function today_noon()
  local n = os.date '*t'
  n.hour, n.min, n.sec = 12, 0, 0
  return os.time(n)
end

local function fmt(t)
  return os.date('%Y-%m-%d', t)
end

--- Compute the next/last occurrence of a weekday.
--- @param target integer 1=Sunday..7=Saturday (matches os.date '*t'.wday)
--- @param direction 'next'|'last'|'this'
local function weekday_date(target, direction)
  local t = today_noon()
  local cur = os.date('*t', t).wday
  local diff
  if direction == 'last' then
    diff = target - cur
    if diff >= 0 then
      diff = diff - 7
    end
  elseif direction == 'next' then
    diff = target - cur
    if diff <= 0 then
      diff = diff + 7
    end
  else -- 'this' / bare day name -> nearest upcoming, or today
    diff = target - cur
    if diff < 0 then
      diff = diff + 7
    end
  end
  return t + diff * DAY
end

--- Parse the text after `@` and return a list of {label, date} candidates.
--- Returns an empty list if nothing reasonable matches.
local function parse(query)
  local q = query:lower():gsub('^%s+', ''):gsub('%s+$', '')
  local items = {}

  local function push(label, date_str)
    table.insert(items, { label = label, date = date_str })
  end

  -- Simple relatives
  local simple = {
    now = function()
      return os.date '%Y-%m-%d %H:%M'
    end,
    today = function()
      return fmt(today_noon())
    end,
    tomorrow = function()
      return fmt(today_noon() + DAY)
    end,
    yesterday = function()
      return fmt(today_noon() - DAY)
    end,
  }
  for kw, f in pairs(simple) do
    if kw:sub(1, #q) == q then
      push('@' .. kw, f())
    end
  end

  -- "next <day>" / "last <day>" / "<day>"
  local dir, rest = q:match '^(%a+)%s+(%a+)$'
  if dir == 'next' or dir == 'last' or dir == 'this' then
    for name, wday in pairs(DAYS) do
      if name:sub(1, #rest) == rest and #rest > 0 then
        push('@' .. dir .. ' ' .. DAY_NAMES[wday], fmt(weekday_date(wday, dir)))
      end
    end
  end

  -- Offer directional completions as the user types "next ", "last "
  if q == 'next' or q == 'last' or q == 'this' then
    for _, name in ipairs(DAY_NAMES) do
      local wday = DAYS[name:lower()]
      push('@' .. q .. ' ' .. name, fmt(weekday_date(wday, q)))
    end
  end

  -- Bare day name: "monday", "tue", ...
  for name, wday in pairs(DAYS) do
    if #q >= 2 and name:sub(1, #q) == q then
      push('@' .. DAY_NAMES[wday], fmt(weekday_date(wday, 'this')))
    end
  end

  -- "in N days/weeks/months"
  local n, unit = q:match '^in%s+(%d+)%s+(%a+)$'
  if n then
    n = tonumber(n)
    local t
    if unit:match '^day' then
      t = today_noon() + n * DAY
    elseif unit:match '^week' then
      t = today_noon() + n * 7 * DAY
    elseif unit:match '^month' then
      local d = os.date('*t', today_noon())
      d.month = d.month + n
      t = os.time(d)
    end
    if t then
      push('@in ' .. n .. ' ' .. unit, fmt(t))
    end
  end

  -- "<month> <day> [year]" e.g. "oct 8", "october 8 2025"
  local m_str, day_str, year_str = q:match '^(%a+)%s+(%d+)%s*(%d*)$'
  if m_str and MONTHS[m_str] then
    local year = tonumber(year_str) ~= nil and tonumber(year_str) or os.date('*t').year
    local t = os.time { year = year, month = MONTHS[m_str], day = tonumber(day_str), hour = 12 }
    push('@' .. os.date('%B', t) .. ' ' .. day_str .. ' ' .. year, fmt(t))
  end

  return items
end

function source.new(opts)
  opts = opts or {}
  local self = setmetatable({}, { __index = source })
  self.opts = opts
  return self
end

function source:get_trigger_characters()
  return { '@' }
end

function source:enabled()
  -- Limit to note-taking filetypes by default; override via opts.filetypes
  local fts = self.opts.filetypes or { 'markdown', 'text', 'org', 'norg', 'gitcommit' }
  return vim.tbl_contains(fts, vim.bo.filetype)
end

function source:get_completions(ctx, callback)
  local line = ctx.line:sub(1, ctx.cursor[2])
  -- Find the last `@` on this line and grab what follows
  local at_col, query = line:find '@([^@]*)$'
  if not at_col then
    callback { items = {}, is_incomplete_backward = false, is_incomplete_forward = false }
    return function() end
  end
  query = line:sub(at_col + 1)

  local matches = parse(query)
  local items = {}
  for i, m in ipairs(matches) do
    local insert = '[' .. m.date .. ']'
    table.insert(items, {
      label = m.label .. ' → ' .. m.date,
      filterText = m.label, -- fuzzy-match against the @phrase
      sortText = string.format('%04d', i),
      kind = require('blink.cmp.types').CompletionItemKind.Text,
      textEdit = {
        newText = insert,
        range = {
          -- Replace from the `@` up to the cursor
          start = { line = ctx.cursor[1] - 1, character = at_col - 1 },
          ['end'] = { line = ctx.cursor[1] - 1, character = ctx.cursor[2] },
        },
      },
      insertTextFormat = vim.lsp.protocol.InsertTextFormat.PlainText,
    })
  end

  callback {
    items = items,
    is_incomplete_backward = true,
    is_incomplete_forward = true,
  }
  return function() end
end

return source
