local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

-- App configuration
local pinned_apps = {
	{
		name = "launchpad",
		icon = " ",
		bundle_id = "com.apple.launchpad.launcher",
		display_name = "Launchpad",
	},
	{
		name = "separator",
		icon = "󱋱",
	},
	{
		name = "finder",
		icon = "󰀶 ",
		bundle_id = "com.apple.finder",
		display_name = "Finder",
		color = 0xff1ba1e6,
	},
	{
		name = "Firefox",
		icon = " ",
		bundle_id = "org.mozilla.firefox",
		display_name = "Firefox",
		color = 0xffff6611,
	},
	{
		name = "WhatsApp",
		icon = "󰖣 ",
		bundle_id = "net.whatsapp.WhatsApp",
		display_name = "WhatsApp",
		color = 0xff25d366,
	},
	{
		name = "Discord",
		icon = " ",
		bundle_id = "com.hnc.Discord",
		color = 0xff5865f2,
		display_name = "Discord",
	},
	{
		name = "outlook",
		icon = "󰴢 ",
		bundle_id = "com.microsoft.Outlook",
		display_name = "Microsoft Outlook",
		color = 0xff0078d4,
	},
	{
		icon = "󱎒 ",
		name = "word",
		bundle_id = "com.microsoft.Word",
		display_name = "Microsoft Word",
		color = 0xff2b579a,
	},
	{
		name = "Appstore",
		icon = " ",
		bundle_id = "com.apple.AppStore",
		display_name = "App Store",
		color = 0xff18bffb,
	},
	{
		name = "Ghostty",
		icon = " ",
		bundle_id = "com.mitchellh.ghostty",
		display_name = "Ghostty",
	},
	{
		name = "Surrealist",
		icon = "󰆼 ",
		bundle_id = "com.surrealdb.surrealist",
		display_name = "Surrealist",
		color = 0xffbd93f9,
	},
	{
		name = "System Settings",
		icon = " ",
		color = 0xff6c6c70,
		bundle_id = "com.apple.systempreferences",
		display_name = "Settings",
	},
}

-- Configuration
local MAX_APPS = 10
local ICON_SPACING = 5
local UPDATE_FREQ = 2000

-- Store app items and bracket for management
local app_items = {}
local apps_bracket = nil

-- Padding items
sbar.add("item", { position = "right", width = settings.group_paddings })
sbar.add("item", { position = "right", width = 0 })

-- Function to get running applications using yabai
local function get_running_apps()
	local handle = io.popen("yabai -m query --windows | jq -r '.[] | .app' | sort -u")
	local output = handle:read("*a")
	handle:close()

	local apps = {}
	if output then
		for line in output:gmatch("[^\r\n]+") do
			local app_name = line:gsub("^%s+", ""):gsub("%s+$", "")
			if app_name ~= "" then
				table.insert(apps, { name = app_name })
			end
		end
	end

	-- Limit to MAX_APPS
	local limited_apps = {}
	for i = 1, math.min(#apps, MAX_APPS) do
		table.insert(limited_apps, apps[i])
	end

	return limited_apps
end

-- Function to get combined list of pinned and non-pinned running apps
local function get_combined_apps()
	local running_apps = get_running_apps()
	local running_app_names = {}
	for _, app in ipairs(running_apps) do
		running_app_names[app.name] = true
	end

	local pinned_bundle_ids = {}
	for _, app in ipairs(pinned_apps) do
		if app.bundle_id then
			pinned_bundle_ids[app.bundle_id] = true
		end
	end

	local non_pinned_running_apps = {}
	for _, app in ipairs(running_apps) do
		-- Since we only have app names, we'll assume non-pinned if not matching a pinned app name
		local is_pinned = false
		for _, pinned in ipairs(pinned_apps) do
			if pinned.name == app.name or (pinned.display_name and pinned.display_name == app.name) then
				is_pinned = true
				break
			end
		end
		if not is_pinned then
			table.insert(non_pinned_running_apps, app)
		end
	end

	local combined_apps = {}
	for _, app in ipairs(pinned_apps) do
		local app_copy = {}
		for k, v in pairs(app) do
			app_copy[k] = v
		end
		app_copy.is_running = running_app_names[app.display_name or app.name] or false
		table.insert(combined_apps, app_copy)
	end
	for _, app in ipairs(non_pinned_running_apps) do
		app.is_running = true
		table.insert(combined_apps, app)
	end

	return combined_apps
end

-- Function to get icon for app
local function get_app_icon(app_name)
	return app_icons[app_name] or app_icons["Default"]
end

-- Function to create app item
local function create_app_item(app, index)
	local item_name = "app_" .. index
	local icon, color, click_script, background

	if app.name == "separator" then
		icon = app.icon
		color = colors.white
		click_script = nil
		background = { drawing = false }
	elseif app.bundle_id then -- Pinned app
		icon = app.icon
		color = app.color or colors.white
		click_script = string.format("open -b '%s'", app.bundle_id)
		background = { drawing = false }
	else -- Running app without bundle_id in pinned list
		icon = get_app_icon(app.name)
		color = colors.white
		click_script = string.format("osascript -e 'tell application \"%s\" to activate'", app.name)
		background = colors.default_background
	end

	local app_item = sbar.add("item", item_name, {
		position = "left",
		icon = {
			string = icon,
			font = "ZedMono Nerd Font:Regular:24.0",
			color = color,
			padding_left = ICON_SPACING,
			padding_right = ICON_SPACING,
			y_offset = 2,
		},
		label = { drawing = false },
		background = background,
		padding_left = 1,
		padding_right = 1,
	})

	-- Add running indicator for pinned apps
	if app.bundle_id and app.is_running then
		app_item:set({
			background = colors.default_background,
		})
	end

	-- Add click functionality
	if click_script then
		app_item:subscribe("mouse.clicked", function(env)
			if env.BUTTON == "left" then
				sbar.exec(click_script)
			elseif env.BUTTON == "right" and not app.bundle_id then -- Only quit non-pinned apps
				sbar.exec(string.format("osascript -e 'tell application \"%s\" to quit'", app.name))
			end
		end)
	end

	return app_item
end

-- Function to update app display
local function update_open_apps()
	local combined_apps = get_combined_apps()

	-- Remove existing items and bracket
	if apps_bracket then
		sbar.remove(apps_bracket)
		apps_bracket = nil
	end
	for _, item in ipairs(app_items) do
		sbar.remove(item.name)
	end
	app_items = {}

	-- Create new app items
	for i, app in ipairs(combined_apps) do
		local app_item = create_app_item(app, i)
		table.insert(app_items, app_item)
	end

	-- Create new bracket
	if #app_items > 0 then
		local bracket_items = {}
		for _, item in ipairs(app_items) do
			table.insert(bracket_items, item.name)
		end
		apps_bracket = sbar.add("bracket", bracket_items, {
			background = colors.transparent,
			padding_left = 8,
			padding_right = 8,
		})
	end
end

-- Create update observer
local apps_observer = sbar.add("item", {
	drawing = false,
	updates = true,
	update_freq = UPDATE_FREQ,
})

-- Subscribe to events
apps_observer:subscribe("routine", update_open_apps)
apps_observer:subscribe("window_focus", update_open_apps)
apps_observer:subscribe("application_launched", update_open_apps)
apps_observer:subscribe("application_terminated", update_open_apps)

-- Initial update
update_open_apps()
