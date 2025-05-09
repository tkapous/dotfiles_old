local M = {}

---@generic T : table
---@param ... T
---@return T
function M.tbl_deep_extend(...)
	local result = {}
	for _, t in ipairs({ ... }) do
		if type(t) == "table" then
			for k, v in pairs(t) do
				if type(v) == "table" and type(result[k] or false) == "table" then
					result[k] = tbl_deep_extend(result[k], v)
				else
					result[k] = v
				end
			end
		end
	end
	return result
end

return M
