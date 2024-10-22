local wezterm = require("wezterm")

wezterm.on("increase-font-size", function(window)
	local font_size = window:get_config().font_size
	font_size = font_size + 1
	local overrides = window:get_config_overrides() or {}
	overrides.font_size = font_size
	window:set_config_overrides(overrides)
end)

wezterm.on("decrease-font-size", function(window)
	local font_size = window:get_config().font_size
	font_size = font_size - 1
	local overrides = window:get_config_overrides() or {}
	overrides.font_size = font_size
	window:set_config_overrides(overrides)
end)

wezterm.on("reset-font-size", function(window)
	local config = require("config")
	local font_size = config.font_size
	local overrides = window:get_config_overrides() or {}
	overrides.font_size = font_size
	window:set_config_overrides(overrides)
end)
