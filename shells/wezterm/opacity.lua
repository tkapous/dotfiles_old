local wezterm = require("wezterm")
local config = require("config")

---@param value number
---@param min number
---@param max number
local function minmax(value, min, max)
	return math.min(math.max(value, min), max)
end

--- @param value number
--- @param up boolean
local function scale_factor(value, up)
	local scale = (1 - value) * 0.1
	scale = minmax(scale, 0.005, 0.99)
	scale = up and scale or -scale
	return 1 + scale
end

--- @param value number
--- @param delta number
local function scale_value(value, delta)
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
--- @param onchange? function
local function scale_window_opacity(window, up, onchange)
	local overrides = window:get_config_overrides()
	local opacity = overrides.window_background_opacity or config.window_background_opacity
	overrides.window_background_opacity = scale_opacity(opacity, up)
	window:set_config_overrides(overrides)
	if onchange then
		onchange(overrides.window_background_opacity)
	end
end

-- track the opacity set by the user via so we can use it on toggle
local opacity_save = config.window_background_opacity

---@param window table
local function toggle_opacity(window)
	local overrides = window:get_config_overrides()
	local opacity = overrides.window_background_opacity
	local new_opacity = opacity < 1 and 1 or opacity_save or config.window_background_opacity
	overrides.window_background_opacity = new_opacity
	window:set_config_overrides(overrides)
end

---@param window table
local function reset_opacity(window)
	local overrides = window:get_config_overrides()
	overrides.window_background_opacity = config.window_background_opacity or 1
	window:set_config_overrides(overrides)
end

local function onOpacityChange(opacity)
	opacity_save = opacity
end

wezterm.on("dec-opacity", function(window)
	scale_window_opacity(window, false, onOpacityChange)
end)

wezterm.on("inc-opacity", function(window)
	scale_window_opacity(window, true, onOpacityChange)
end)

wezterm.on("toggle-opacity", toggle_opacity)

wezterm.on("reset-opacity", reset_opacity)
