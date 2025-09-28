local M = {}

M.open_in_browser = function()
  -- Get current file path relative to working directory
  local file_path = vim.fn.expand "%:p"
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

  if git_root == "" then
    vim.notify("Not in a git repository", vim.log.levels.ERROR)
    return
  end

  -- Convert paths to same format and make relative
  git_root = git_root:gsub("\\", "/"):gsub("/$", "")
  file_path = file_path:gsub("\\", "/")
  file_path = file_path:sub(#git_root + 2)

  -- Get git remote URL
  local remote_url = vim.fn.systemlist("git remote get-url origin")[1]
  if not remote_url or remote_url == "" then
    vim.notify("Not in a git repository", vim.log.levels.ERROR)
    return
  end

  -- Transform SSH URL to HTTPS if needed
  remote_url = remote_url:gsub(":", "/")
  remote_url = remote_url:gsub("%.git$", "")
  remote_url = remote_url:gsub("git@", [[https://]])

  -- Handle custom GitLab domains
  if remote_url:match "git%.ifoodcorp%.com%.br" then
    remote_url = remote_url:gsub("git%.ifoodcorp%.com%.br", "code.ifoodcorp.com.br")
  end

  -- Get current branch
  local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]

  -- Construct the URL
  local url = remote_url

  -- Handle GitHub vs GitLab URLs
  if remote_url:match "github%.com" then
    url = url .. "/blob/" .. branch .. "/" .. file_path
  else -- Assume GitLab
    url = url .. "/-/blob/" .. branch .. "/" .. file_path
  end

  -- Add line numbers in visual mode
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" then
    local start_line = vim.fn.line "v"
    local end_line = vim.fn.line "."
    url = url .. "#L" .. start_line
    if start_line ~= end_line then
      url = url .. "-" .. "L" .. end_line
    end
  end

  -- Open in browser
  local os_name = vim.loop.os_uname().sysname
  local cmd
  if os_name == "Linux" then
    cmd = 'xdg-open "' .. url .. '"'
  elseif os_name == "Darwin" then
    cmd = 'open "' .. url .. '"'
  elseif os_name == "Windows" then
    cmd = 'start "" "' .. url .. '"'
  else
    vim.notify("Unsupported OS for opening browser", vim.log.levels.ERROR)
    return
  end

  vim.fn.system(cmd)
  vim.notify("Opened in browser: " .. url, vim.log.levels.INFO)
end

return M
