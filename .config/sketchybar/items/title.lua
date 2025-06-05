local colors = require("colors")
local settings = require("settings")

-- Configuration
local MAX_APP_LENGTH = 30
local UPDATE_FREQ = 1000 -- milliseconds

-- Create the active app item
local active_app = sbar.add("item", "active_app", {
	position = "right",
	icon = {
		string = "󰣆 ",
		font = {
			family = settings.font.text,
			style = "Bold",
			size = 20.0,
		},
		color = colors.white,
		padding_left = 0,
		padding_right = 10,
	},
	label = {
		string = "No Active App",
		font = {
			family = settings.font.text,
			style = "Bold",
			size = 16.0,
		},
		color = colors.white,
		padding_right = 15,
		max_chars = MAX_APP_LENGTH,
	},
	background = colors.transparent,
	padding_left = 0,
	padding_right = 5,
	updates = true,
	update_freq = UPDATE_FREQ,
})

-- Function to truncate long app names
local function truncate_app_name(app_name, max_length)
	if string.len(app_name) <= max_length then
		return app_name
	else
		return string.sub(app_name, 1, max_length - 3) .. "..."
	end
end

-- Function to get the current active app name
local function get_active_app()
	-- Try to get app name using yabai
	local handle = io.popen("yabai -m query --windows --window | jq -r '.app // empty'")
	local app_name = handle:read("*a")
	handle:close()

	if app_name and app_name ~= "" then
		app_name = app_name:gsub("\n", ""):gsub("\r", "")
		return truncate_app_name(app_name, MAX_APP_LENGTH)
	end

	-- Fallback: try using AppleScript
	local applescript = [[
		tell application "System Events"
			set frontApp to first application process whose frontmost is true
			return name of frontApp
		end tell
	]]

	local handle2 = io.popen("osascript -e '" .. applescript .. "' 2>/dev/null")
	local fallback_app = handle2:read("*a")
	handle2:close()

	if fallback_app and fallback_app ~= "" then
		fallback_app = fallback_app:gsub("\n", ""):gsub("\r", "")
		return truncate_app_name(fallback_app, MAX_APP_LENGTH)
	end

	return "No Active App"
end

-- Update function
local function update_active_app()
	local app_name = get_active_app()
	local display_name = app_name == "" and "Finder" or app_name

	active_app:set({
		label = { string = display_name },
	})
end

-- Event subscriptions
active_app:subscribe("routine", function()
	update_active_app()
end)

-- Subscribe to window focus changes (requires yabai)
active_app:subscribe("window_focus", function()
	update_active_app()
end)

-- Subscribe to space changes
active_app:subscribe("space_change", function()
	update_active_app()
end)

-- Initial update
update_active_app()

-- Optional: Add a trigger for manual updates
sbar.add("event", "update_active_app")
active_app:subscribe("update_active_app", function()
	update_active_app()
end)
