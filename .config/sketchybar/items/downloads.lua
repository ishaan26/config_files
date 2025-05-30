local settings = require("settings")
local colors = require("colors")

-- Padding item required because of bracket
sbar.add("item", {
	position = "right",
	width = settings.group_paddings,
})

local downloads = sbar.add("item", {
	icon = {
		string = "􀈄", -- SF Symbol for download (arrow.down.circle)
		color = colors.white,
		padding_left = 8,
		padding_right = 12,
		font = {
			family = settings.font.text,
			style = "Bold",
			size = 16.0,
		},
	},
	label = {
		string = "Downloads",
		color = colors.white,
		padding_right = 8,
		width = 75,
		align = "right",
		font = {
			family = settings.font.text,
			style = "Bold",
			size = 16.0,
		},
	},
	position = "right",
	padding_left = 1,
	padding_right = 1,
	background = {
		color = colors.with_alpha(colors.black, 0.8),
		border_color = colors.transparent,
		border_width = 0,
		height = 35,
	},
})

-- Create popup for recent downloads
local downloads_popup = sbar.add("item", {
	position = "popup." .. downloads.name,
	width = 300,
	icon = {
		string = "Recent Downloads:",
		color = colors.white,
		font = {
			style = "Bold",
			size = 16.0,
		},
		padding_left = 10,
		padding_right = 10,
	},
	background = {
		color = colors.transparent,
		border_color = colors.transparent,
		border_width = 0,
		height = 35,
	},
})

-- Function to get recent downloads
local function get_recent_downloads()
	local handle = io.popen("ls -t ~/Downloads | head -10")
	local result = handle:read("*a")
	handle:close()

	local files = {}
	for file in result:gmatch("[^\r\n]+") do
		-- Skip hidden files and common system files
		if not file:match("^%.") and file ~= "" then
			table.insert(files, file)
		end
	end

	return files
end

-- Track if popup content has been created
local popup_created = false

-- Function to update popup content
local function update_downloads_popup()
	-- Only create popup items once
	if popup_created then
		return
	end

	popup_created = true

	local recent_files = get_recent_downloads()

	for i, file in ipairs(recent_files) do
		if i <= 8 then -- Limit to 8 files to prevent overflow
			-- Truncate long filenames
			local display_name = file
			if #file > 35 then
				display_name = file:sub(1, 32) .. "..."
			end

			-- Get file extension for icon
			local extension = file:match("%.([^%.]+)$") or ""
			local file_icon = "􀈷" -- Default document icon

			-- Set icons based on file type
			if extension:match("^(jpg|jpeg|png|gif|bmp|svg)$") then
				file_icon = "􀏅 " -- photo icon
			elseif extension:match("^(mp4|mov|avi|mkv)$") then
				file_icon = "􀎶 " -- video icon
			elseif extension:match("^(mp3|wav|aac|flac)$") then
				file_icon = "􀑪 " -- music icon
			elseif extension:match("^(pdf)$") then
				file_icon = " " -- PDF icon
			elseif extension:match("^(zip|rar|7z|tar|gz)$") then
				file_icon = " " -- archive icon
			elseif extension:match("^(txt|md|rtf)$") then
				file_icon = " " -- text icon
			elseif extension:match("^(dmg|pkg)$") then
				file_icon = "􀈩 " -- installer icon
			end

			sbar.add("item", {
				position = "popup." .. downloads.name,
				icon = {
					string = file_icon,
					color = colors.white,
					font = { size = 14.0 },
					padding_left = 15,
					padding_right = 8,
				},
				label = {
					string = display_name,
					color = colors.white,
					font = {
						family = settings.font.text,
						size = 14.0,
					},
					padding_right = 15,
					max_chars = 35,
				},
				background = {
					color = colors.transparent,
					border_color = colors.transparent,
					border_width = 0,
					height = 35,
				},
				click_script = "open ~/Downloads/'" .. file:gsub("'", "'\\''") .. "'",
			})
		end
	end

	-- Add "Open Downloads" footer
	sbar.add("item", {
		position = "popup." .. downloads.name,
		icon = {
			string = "􀈞", -- folder icon
			color = colors.blue,
			font = { size = 14.0 },
			padding_left = 15,
			padding_right = 8,
		},
		label = {
			string = "Open Downloads Folder",
			color = colors.blue,
			font = {
				family = settings.font.text,
				size = 14.0,
				style = "Bold",
			},
			padding_right = 15,
		},
		background = {
			color = colors.transparent,
			border_color = colors.transparent,
			border_width = 0,
			height = 35,
		},
		click_script = "open ~/Downloads && sketchybar --set " .. downloads.name .. " popup.drawing=off",
	})
end

-- Double border for downloads using a single item bracket
sbar.add("bracket", { downloads.name }, {
	background = {
		color = colors.transparent,
		border_color = colors.transparent,
		border_width = 0,
		height = 35,
	},
})

-- Padding item required because of bracket
sbar.add("item", {
	position = "right",
	width = settings.group_paddings,
})

-- Mouse events for popup
downloads:subscribe("mouse.clicked", function(env)
	if env.BUTTON == "right" then
		if not popup_created then
			update_downloads_popup()
		end
		downloads:set({ popup = { drawing = "toggle" } })
	elseif env.BUTTON == "left" then
		-- Handle left click to open Downloads folder
		downloads:set({ popup = { drawing = "off" } })
		os.execute("open ~/Downloads")
	end
end)

downloads:subscribe("mouse.exited.global", function(env)
	downloads:set({ popup = { drawing = "off" } })
end)

downloads:subscribe("mouse.exited.global", function(env)
	downloads:set({ popup = { drawing = "off" } })
end)

-- Force refresh of popup content when Downloads folder changes
downloads:subscribe("routine", function(env)
	local handle = io.popen("ls ~/Downloads | wc -l")
	local count = handle:read("*n")
	handle:close()

	if count and count > 0 then
		downloads:set({
			label = count .. " items",
		})
	else
		downloads:set({
			label = "Downloads",
		})
	end

	-- Reset popup created flag to allow refresh on next hover
	popup_created = false
end)
