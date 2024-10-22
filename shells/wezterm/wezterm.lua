local wezterm = require("wezterm")
require("opacity")

local config = require("config")
local schemes = {}
for name, scheme in pairs(wezterm.get_builtin_color_schemes()) do
	table.insert(schemes, name)
end

return config
