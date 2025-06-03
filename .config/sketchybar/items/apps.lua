local settings = require("settings")
local colors = require("colors")

-- App configuration
local apps = {
	{
		name = "settings",
		icon = " ",
		color = 0xff6c6c70,
		bundle_id = "com.apple.systempreferences",
		display_name = "Settings",
	},
	{
		name = "surrealist",
		icon = "󰆼 ",
		bundle_id = "com.surrealdb.surrealist",
		display_name = "Surrealist",
		color = 0xffbd93f9,
	},
	{
		name = "ghostty",
		icon = " ", -- Terminal icon
		bundle_id = "com.mitchellh.ghostty",
		display_name = "Ghostty",
	},
	{
		name = "appstore",
		icon = " ",
		bundle_id = "com.apple.AppStore",
		display_name = "App Store",
		color = 0xff18bffb,
	},
	{
		icon = "󱎒 ", -- Word icon
		name = "word",
		bundle_id = "com.microsoft.Word",
		display_name = "Microsoft Word",
		color = 0xff2b579a,
	},
	{
		name = "outlook",
		icon = "󰴢 ", -- Outlook icon
		bundle_id = "com.microsoft.Outlook",
		display_name = "Microsoft Outlook",
		color = 0xff0078d4,
	},
	{
		name = "discord",
		icon = " ", -- Discord icon
		bundle_id = "com.hnc.Discord",
		color = 0xff5865f2,
		display_name = "Discord",
	},
	{
		name = "whatsapp",
		icon = "󰖣 ", -- WhatsApp icon (requires Nerd Font)
		bundle_id = "net.whatsapp.WhatsApp",
		display_name = "WhatsApp",
		color = 0xff25d366,
	},
	{
		name = "firefox",
		icon = " ", -- Firefox icon (requires Nerd Font)
		bundle_id = "org.mozilla.firefox",
		display_name = "Firefox",
		color = 0xffff6611,
	},
	{
		name = "finder",
		icon = "󰀶 ",
		bundle_id = "com.apple.finder",
		display_name = "Finder",
		color = 0xff1ba1e6,
	},
	{
		name = "separator",
		icon = "󱋱",
	},
	{
		name = "launchpad",
		icon = " ", -- Grid/Launchpad icon
		bundle_id = "com.apple.launchpad.launcher",
		display_name = "Launchpad",
	},
}

-- Padding item before apps group
sbar.add("item", { position = "right", width = settings.group_paddings })

local app_items = {}

-- Create app items
for _, app in ipairs(apps) do
	local app_item = sbar.add("item", {
		icon = {
			string = app.icon,
			color = app.color,
			padding_left = 8,
			padding_right = 8,
			font = "ZedMono Nerd Font:Regular:24.0",
			y_offset = 2,
		},
		label = { drawing = false }, -- Hide label, only show icon
		position = "right",
		padding_left = 1,
		padding_right = 1,
		background = { drawing = false }, -- No individual backgrounds
		click_script = string.format("open -b '%s'", app.bundle_id),
	})

	-- Store reference for bracket grouping
	table.insert(app_items, app_item.name)
end

-- Group all app items with a bracket (single unified background)
sbar.add("bracket", app_items, {
	background = colors.transparent,
})

-- Padding item after apps group
sbar.add("item", { position = "right", width = settings.group_paddings })

-- Initialize app states
sbar.exec("yabai -m query --windows --window", function(result)
	local front_app = result and result:match('"app":"([^"]*)"')
	if front_app then
		sbar.trigger("front_app_switched", { INFO = front_app })
	end
end)
