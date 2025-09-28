vim.cmd [[ 
packadd org-social.nvim
]]

if not pcall(require, "org-social") then
  return
end

require("org-social").setup {
  social_file = vim.fn.expand "~/git/blog/static/social.org",
  nickname = "cherry",
  path = "https://cherryramatis.xyz/social.org",
}
