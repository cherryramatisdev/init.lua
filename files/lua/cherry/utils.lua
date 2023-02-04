local M = {}

function M.index_of(array, value)
	for i, v in ipairs(array) do
		if v == value then
			return i
		end
	end
	return nil
end

return M
