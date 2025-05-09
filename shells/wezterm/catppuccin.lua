local wezterm = require("wezterm")

local custom_latte = wezterm.color.get_builtin_schemes()["Catppuccin Latte"]
custom_latte.ansi[1] = "#d6d9e1"

local custom_frappe = wezterm.color.get_builtin_schemes()["Catppuccin Frappe"]
custom_frappe.background = "#1e1e2e"

return {
	["Catppuccin Latte"] = custom_latte,
	["Catppuccin Frappe"] = custom_frappe,
}
