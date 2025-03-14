local wezterm = require("wezterm")
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

require("colorscheme")

config = {
	enable_wayland = true,
	line_height = 1.3,
	window_padding = {
		left = 8,
		right = 6,
		top = 10,
		bottom = 10,
	},
	-- font = wezterm.font("JetBrainsMono NF", { weight = "Regular", stretch = "UltraExpanded" }),
	-- font = wezterm.font("UbuntuMono Nerd Font Mono", { weight = "Regular", stretch = "Normal" }),
	font = wezterm.font("JetBrainsMono NF"),
	hide_tab_bar_if_only_one_tab = true,
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	window_decorations = "RESIZE",
	adjust_window_size_when_changing_font_size = false,
	colors = {
		tab_bar = {
			background = "rgba(0,0,0,0)",
		},
		cursor_bg = "#b4b4b4",
	},
	window_background_opacity = 0.9,
	-- <alt--> to increase window opacity
	keys = {
		{ key = "UpArrow", mods = "SHIFT", action = wezterm.action.ScrollByPage(-0.1) },
		{ key = "DownArrow", mods = "SHIFT", action = wezterm.action.ScrollByPage(0.1) },
		{ key = "=", mods = "ALT", action = wezterm.action.EmitEvent("inc-opacity") },
		{ key = "-", mods = "ALT", action = wezterm.action.EmitEvent("dec-opacity") },
		{ key = "0", mods = "ALT", action = wezterm.action.EmitEvent("toggle-opacity") },
		{ key = "0", mods = "CTRL|ALT", action = wezterm.action.EmitEvent("reset-opacity") },
		{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
		{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
		{ key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },
		{ key = "O", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
		{ key = "I", mods = "CTRL", action = wezterm.action.ActivateTabRelative(-1) },
	},
}

return config
