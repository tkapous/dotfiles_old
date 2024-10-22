local wezterm = require("wezterm")
local config = require("config")

--- @param value number
--- @param up boolean
local function scale_factor(value, up)
	local scale = (1 - value) * 0.1
	if scale < 0.005 then
		scale = 0.005
	end
	if scale > 0.99 then
		scale = 0.99
	end
	return up and 1 + scale or 1 - scale
end

--- @param value number
--- @param delta number
local scale_value = function(value, delta)
	value = value * delta
	if value < 0.1 then
		value = 0.1
	end
	if value > 0.995 then
		value = 1
	end
	return value
end

--- @param opacity number
--- @param up boolean
local function scale_opacity(opacity, up)
	return scale_value(opacity, scale_factor(opacity, up))
end

--- @param window table
--- @param up boolean
local function scale_window_opacity(window, up)
	local overrides = window:get_config_overrides() or {}
	local opacity = overrides.window_background_opacity or config.window_background_opacity
	overrides.window_background_opacity = scale_opacity(opacity, up)
	window:set_config_overrides(overrides)
end

wezterm.on("dec-opacity", function(window)
	scale_window_opacity(window, false)
end)

wezterm.on("inc-opacity", function(window)
	scale_window_opacity(window, true)
end)

wezterm.on("reset-opacity", function(window)
	local overrides = window:get_config_overrides() or {}
	overrides.window_background_opacity = 1.0
	window:set_config_overrides(overrides)
end)
