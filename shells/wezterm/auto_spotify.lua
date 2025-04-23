local wezterm = require("wezterm")
local io = require("io")

local function is_spotify_running()
	local handle = io.popen("pgrep spotify")
	if not handle then
		return false
	end
	local result = handle:read("*a")
	handle:close()
	return result ~= ""
end

local function is_spotify_playing()
	local handle = io.popen("playerctl -p spotify status")
	if not handle then
		return false
	end
	local result = handle:read("*a")
	handle:close()
	return result:match("Playing")
end

local function is_any_sound_playing()
	local players_handle = io.popen("playerctl -l")
	if not players_handle then
		return false
	end
	wezterm.log_warn("Checking for any sound playing")
	for player in players_handle:lines() do
		wezterm.log_warn("|" .. player .. "|")
		local handle = io.popen("playerctl -p " .. player .. " status")
		if not handle then
			return false
		end
		local result = handle:read("*a")
		wezterm.log_warn(result)
		handle:close()
		if result:match("Playing") then
			return true
		end
	end
end

local function play_spotify()
	os.execute("notify-send --transient --app-name='Wezterm Auto Spotify' 'Spotify' 'Playing Spotify'")
	os.execute("playerctl -p spotify play")
end

wezterm.on("window-focus-changed", function(window)
	return window:is_focused()
		and is_spotify_running()
		and not is_spotify_playing()
		and not is_any_sound_playing()
		and play_spotify()
end)
