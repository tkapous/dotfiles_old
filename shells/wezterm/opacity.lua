local M = {}

local wezterm = require("wezterm")

M.opacity = require("config").window_background_opacity
M.default_opacity = nil

local function onOpacityChange(opacity)
  M.opacity = opacity
  if M.default_opacity == nil then
    M.default_opacity = opacity
  end
end

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
  local opacity = overrides.window_background_opacity or M.opacity or 1
  M.opacity = opacity
  overrides.window_background_opacity = scale_opacity(opacity, up)
  window:set_config_overrides(overrides)
  if onchange then
    onchange(overrides.window_background_opacity)
  end
end

---@param window table
local function toggle_opacity(window)
  local overrides = window:get_config_overrides().window_background_opacity
  overrides.window_background_opacity = overrides.window_background_opacity < 1 and 1 or M.opacity
  window:set_config_overrides(overrides)
end

---@param window table
local function reset_opacity(window)
  local overrides = window:get_config_overrides()
  overrides.window_background_opacity = M.default_opacity or 1
  window:set_config_overrides(overrides)
end

wezterm.on("dec-opacity", function(window)
  scale_window_opacity(window, false, onOpacityChange)
end)

wezterm.on("inc-opacity", function(window)
  scale_window_opacity(window, true, onOpacityChange)
end)

wezterm.on("toggle-opacity", toggle_opacity)

wezterm.on("reset-opacity", reset_opacity)

return M
