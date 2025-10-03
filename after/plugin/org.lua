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
    t = { description = "Task", template = "** TODO %?\nSCHEDULED: %^T\nRef: %a", headline = "Inbox" },
    m = {
      description = "Meeting",
      template = "** TODO %?\nSCHEDULED: %^T\n\nGoal:\nAnnotations:\nQuestions:\nResults/Summary:",
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
