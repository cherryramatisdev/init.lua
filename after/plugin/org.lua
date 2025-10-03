vim.pack.add {
  "https://github.com/nvim-orgmode/orgmode",
}

if not pcall(require, "orgmode") then
  return
end

require("orgmode").setup {
  org_agenda_files = "~/git/stowed/org/*.org",
  org_default_notes_file = "~/git/stowed/org/todo.org",
  org_todo_keywords = {'TODO(t)', 'PROGRESS(p)', '|', 'MEETING(m)', 'DONE(d)'},
  org_capture_templates = {
    t = { description = "Task", template = "** TODO %?\n  SCHEDULED: %^T\n  Ref: %a", headline = "Inbox" },
    m = {
      description = "Meeting",
      template = "** MEETING %?\n  SCHEDULED: %^T\n\n  Goal:\n  Annotations:\n  Questions:\n  Results/Summary:",
      headline = "Meetings",
    },
  },
}

vim.pack.add {
  "https://github.com/chipsenkbeil/org-roam.nvim",
}

if not pcall(require, "org-roam") then
  return
end

require("org-roam").setup {
  directory = "~/git/stowed/org/roam/",
}
