local wezterm = require("wezterm")

local themes = {
	Light = "tokyonight_day",
	Dark = "tokyonight_moon",
	LightHighContrast = "tokyonight_day",
	DarkHighContrast = "tokyonight_moon",
}

local function change_theme(window)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()
	local scheme = themes[appearance] or "tokyonight_moon"
	if overrides.color_scheme ~= scheme then
		overrides.color_scheme = scheme
		window:set_config_overrides(overrides)
	end
end

wezterm.on("window-config-reloaded", change_theme)
