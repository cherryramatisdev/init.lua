local generator = function()
	local el_segments = {}

	local extensions = require("el.extensions")
	local subscribe = require("el.subscribe")
	table.insert(el_segments, extensions.mode)

	table.insert(el_segments, " ")

	table.insert(
		el_segments,
		subscribe.buf_autocmd("el_git_branch", "BufEnter", function(window, buffer)
			local branch = extensions.git_branch(window, buffer)
			if branch then
				local git_icon = require("nvim-web-devicons").get_icon_by_filetype("git", {})
				return git_icon .. " " .. branch
			end
		end)
	)

	return el_segments
end

require("el").setup({ generator = generator })
