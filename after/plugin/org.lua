vim.pack.add {
  "https://github.com/nvim-orgmode/orgmode",
}

if not pcall(require, "orgmode") then
  return
end

require("orgmode").setup {
  org_agenda_files = "~/git/stowed/org/*.org",
  org_default_notes_file = "~/git/stowed/org/todo.org",
  org_capture_templates = { 
      t = { description = 'Task', template = '** TODO %?\nSCHEDULED: %^T\nRef: %a', headline = 'Inbox' },
      m = { description = 'Meeting', template = '** TODO %?\nSCHEDULED: %^T\n\nGoal:\nAnnotations:\nQuestions:\nResults/Summary:', headline = 'Meetings' },
  },
}

vim.pack.add {
  "https://github.com/hamidi-dev/org-super-agenda.nvim",
}

if not pcall(require, "org-super-agenda") then
  return
end

require("org-super-agenda").setup {
  org_files = { "~/git/stowed/org/*.org" },
  org_directories = { "~/git/stowed/org" },
  exclude_files = {},
  exclude_directories = {},
  todo_states = {
    {
      name = "TODO",
      keymap = "ot",
      color = "#FF5555",
      strike_through = false,
      fields = { "filename", "todo", "headline", "priority", "date", "tags" },
    },
    {
      name = "PROGRESS",
      keymap = "op",
      color = "#FFAA00",
      strike_through = false,
      fields = { "filename", "todo", "headline", "priority", "date", "tags" },
    },
    {
      name = "WAITING",
      keymap = "ow",
      color = "#BD93F9",
      strike_through = false,
      fields = { "filename", "todo", "headline", "priority", "date", "tags" },
    },
    {
      name = "DONE",
      keymap = "od",
      color = "#50FA7B",
      strike_through = true,
      fields = { "filename", "todo", "headline", "priority", "date", "tags" },
    },
  },
  keymaps = {
    filter_reset = "oa", -- reset all filters
    toggle_other = "oo", -- toggle catch-all "Other" section
    filter = "of", -- live filter (exact text)
    filter_fuzzy = "oz", -- live filter (fuzzy)
    filter_query = "oq", -- advanced query input
    undo = "u", -- undo last change
    reschedule = "cs", -- set/change SCHEDULED
    set_deadline = "cd", -- set/change DEADLINE
    cycle_todo = "t", -- cycle TODO state
    reload = "r", -- refresh agenda
    refile = "R", -- refile via Telescope/org-telescope
    hide_item = "x", -- hide current item
    preview = "K", -- preview headline content
    reset_hidden = "X", -- clear hidden list
    toggle_duplicates = "D", -- duplicate items may appear in multiple groups
    cycle_view = "ov", -- switch view (classic/compact)
  },
  window = {
    width = 0.8,
    height = 0.7,
    border = "rounded",
    title = "Org Super Agenda",
    title_pos = "center",
    margin_left = 0,
    margin_right = 0,
    fullscreen_border = "none", -- border style when using fullscreen
  },
  groups = {
    {
      name = "📅 Today",
      matcher = function(i)
        return i.scheduled and i.scheduled:is_today()
      end,
      sort = { by = "priority", order = "desc" },
    },
    {
      name = "🗓️ Tomorrow",
      matcher = function(i)
        return i.scheduled and i.scheduled:days_from_today() == 1
      end,
    },
    {
      name = "☠️ Deadlines",
      matcher = function(i)
        return i.deadline and i.todo_state ~= "DONE" and not i:has_tag "personal"
      end,
      sort = { by = "deadline", order = "asc" },
    },
    {
      name = "⭐ Important",
      matcher = function(i)
        return i.priority == "A" and (i.deadline or i.scheduled)
      end,
      sort = { by = "date_nearest", order = "asc" },
    },
    {
      name = "⏳ Overdue",
      matcher = function(i)
        return i.todo_state ~= "DONE"
          and ((i.deadline and i.deadline:is_past()) or (i.scheduled and i.scheduled:is_past()))
      end,
      sort = { by = "date_nearest", order = "asc" },
    },
    {
      name = "🏠 Personal",
      matcher = function(i)
        return i:has_tag "personal"
      end,
    },
    {
      name = "💼 Work",
      matcher = function(i)
        return i:has_tag "work"
      end,
    },
    {
      name = "📆 Upcoming",
      matcher = function(i)
        local days = require("org-super-agenda.config").get().upcoming_days or 10
        local d1 = i.deadline and i.deadline:days_from_today()
        local d2 = i.scheduled and i.scheduled:days_from_today()
        return (d1 and d1 >= 0 and d1 <= days) or (d2 and d2 >= 0 and d2 <= days)
      end,
      sort = { by = "date_nearest", order = "asc" },
    },
  },

  upcoming_days = 10,
  hide_empty_groups = true, -- drop blank sections
  keep_order = false, -- keep original org order (rarely useful)
  allow_duplicates = false, -- if true, an item can live in multiple groups
  group_format = "* %s", -- group header format
  other_group_name = "Other",
  show_other_group = false, -- show catch-all section
  show_tags = true, -- draw tags on the right
  show_filename = true, -- include [filename]
  heading_max_length = 70,
  persist_hidden = false, -- keep hidden items across reopen
  view_mode = "classic", -- 'classic' | 'compact'

  classic = {
    heading_order = { "filename", "todo", "priority", "headline" },
    short_date_labels = false,
    inline_dates = true,
  },
  compact = { filename_min_width = 10, label_min_width = 12 },

  group_sort = { by = "date_nearest", order = "asc" },

  debug = false,
}

vim.keymap.set("n", "<leader>oa", ":OrgSuperAgenda!", { desc = "org super agenda", remap = true })

vim.pack.add {
  "https://github.com/chipsenkbeil/org-roam.nvim",
}

if not pcall(require, "org-roam") then
  return
end

require("org-roam").setup {
  directory = "~/git/stowed/org/roam/",
}
