local weather_vars = require("weather_vars")
local colors = require("colors")
local settings = require("settings")

local popup_width = 160

local weather_icons_day = {
	[1000] = "", -- Sunny/113
	[1003] = "", -- Partly cloudy/116
	[1006] = "", -- Cloudy/119
	[1009] = "", -- Overcast/122
	[1030] = "", -- Mist/143
	[1063] = "", -- Patchy rain possible/176
	[1066] = "", -- Patchy snow possible/179
	[1069] = "", -- Patchy sleet possible/182
	[1072] = "", -- Patchy freezing drizzle possible/185
	[1087] = "", -- Thundery outbreaks possible/200
	[1114] = "", -- Blowing snow/227
	[1117] = "", -- Blizzard/230
	[1135] = "", -- Fog/248
	[1147] = "", -- Freezing fog/260
	[1150] = "", -- Patchy light drizzle/263
	[1153] = "", -- Light drizzle/266
	[1168] = "", -- Freezing drizzle/281
	[1171] = "", -- Heavy freezing drizzle/284
	[1180] = "", -- Patchy light rain/293
	[1183] = "", -- Light rain/296
	[1186] = "", -- Moderate rain at times/299
	[1189] = "", -- Moderate rain/302
	[1192] = "", -- Heavy rain at times/305
	[1195] = "", -- Heavy rain/308
	[1198] = "", -- Light freezing rain/311
	[1201] = "", -- Moderate or heavy freezing rain/314
	[1204] = "", -- Light sleet/317
	[1207] = "", -- Moderate or heavy sleet/320
	[1210] = "", -- Patchy light snow/323
	[1213] = "", -- Light snow/326
	[1216] = "", -- Patchy moderate snow/329
	[1219] = "", -- Moderate snow/332
	[1222] = "", -- Patchy heavy snow/335
	[1225] = "", -- Heavy snow/338
	[1237] = "", -- Ice pellets/350
	[1240] = "", -- Light rain shower/353
	[1243] = "", -- Moderate or heavy rain shower/356
	[1246] = "", -- Torrential rain shower/359
	[1249] = "", -- Light sleet showers/362
	[1252] = "", -- Moderate or heavy sleet showers/365
	[1255] = "", -- Light snow showers/368
	[1258] = "", -- Moderate or heavy snow showers/371
	[1261] = "", -- Light showers of ice pellets/374
	[1264] = "", -- Moderate or heavy showers of ice pellets/377
	[1273] = "", -- Patchy light rain with thunder/386
	[1276] = "", -- Moderate or heavy rain with thunder/389
	[1279] = "", -- Patchy light snow with thunder/392
	[1282] = "", -- Moderate or heavy snow with thunder/395
}

local weather_icons_night = {
	[1000] = "", -- Clear/113
	[1003] = "", -- Partly cloudy/116
	[1006] = "", -- Cloudy/119
	[1009] = "", -- Overcast/122
	[1030] = "", -- Mist/143
	[1063] = "", -- Patchy rain possible/176
	[1066] = "", -- Patchy snow possible/179
	[1069] = "", -- Patchy sleet possible/182
	[1072] = "", -- Patchy freezing drizzle possible/185
	[1087] = "", -- Thundery outbreaks possible/200
	[1114] = "", -- Blowing snow/227
	[1117] = "", -- Blizzard/230
	[1135] = "", -- Fog/248
	[1147] = "", -- Freezing fog/260
	[1150] = "", -- Patchy light drizzle/263
	[1153] = "", -- Light drizzle/266
	[1168] = "", -- Freezing drizzle/281
	[1171] = "", -- Heavy freezing drizzle/284
	[1180] = "", -- Patchy light rain/293
	[1183] = "", -- Light rain/296
	[1186] = "", -- Moderate rain at times/299
	[1189] = "", -- Moderate rain/302
	[1192] = "", -- Heavy rain at times/305
	[1195] = "", -- Heavy rain/308
	[1198] = "", -- Light freezing rain/311
	[1201] = "", -- Moderate or heavy freezing rain/314
	[1204] = "", -- Light sleet/317
	[1207] = "", -- Moderate or heavy sleet/320
	[1210] = "", -- Patchy light snow/323
	[1213] = "", -- Light snow/326
	[1216] = "", -- Patchy moderate snow/329
	[1219] = "", -- Moderate snow/332
	[1222] = "", -- Patchy heavy snow/335
	[1225] = "", -- Heavy snow/338
	[1237] = "", -- Ice pellets/350
	[1240] = "", -- Light rain shower/353
	[1243] = "", -- Moderate or heavy rain shower/356
	[1246] = "", -- Torrential rain shower/359
	[1249] = "", -- Light sleet showers/362
	[1252] = "", -- Moderate or heavy sleet showers/365
	[1255] = "", -- Light snow showers/368
	[1258] = "", -- Moderate or heavy snow showers/371
	[1261] = "", -- Light showers of ice pellets/374
	[1264] = "", -- Moderate or heavy showers of ice pellets/377
	[1273] = "", -- Patchy light rain with thunder/386
	[1276] = "", -- Moderate or heavy rain with thunder/389
	[1279] = "", -- Patchy light snow with thunder/392
	[1282] = "", -- Moderate or heavy snow with thunder/395
}

local weather = sbar.add("item", "widgets.weather", {
	position = "right",
	icon = {
		font = { family = "JetBrainsMono Nerd Font", style = "Regular", size = 16 },
		color = colors.magenta,
		y_offset = 1,
	},
	update_freq = 3600,
	label = {
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Bold"],
			size = 16.0,
		},
		align = "right",
	},
	popup = {
		align = "right",
		height = 30,
		width = popup_width,
		icon = {
			font = { family = "JetBrainsMono Nerd Font", style = "Regular", size = 16 },
		},
		label = {
			font = { family = "JetBrainsMono Nerd Font", style = "Regular", size = 16 },
		},
		drawing = false,
	},
})

local function get_icon(condition, is_day)
	if is_day == 1 then
		return weather_icons_day[condition] or condition
	else
		return weather_icons_night[condition] or condition
	end
end

sbar.add("bracket", "widgets.weather.bracket", { weather.name }, {
	background = colors.default_background,
})

sbar.add("item", "widgets.weather.padding", {
	position = "right",
	width = settings.group_paddings,
})

local function toggle_weather()
	sbar.remove("/weather.location/")
	sbar.remove("/weather.condition/")
	sbar.remove("/weather.day.*/")
	sbar.remove("/weather.day.*.hourly.*/")

	local url = string.format(
		"curl -s 'http://api.weatherapi.com/v1/forecast.json?key=%s&q=%s&days=3'",
		weather_vars.api_key or "auto:ip",
		weather_vars.location or "London"
	)
	sbar.exec(url, function(data)
		local icon = get_icon(data.current.condition.code, data.current.is_day)

		weather:set({
			icon = {
				string = icon,
			},
			label = {
				string = string.format("%s°C", math.floor(data.current.temp_c)),
			},
		})

		sbar.add("item", "weather.location", {
			position = "popup." .. weather.name,
			align = "center",
			width = popup_width,
			icon = {
				font = { family = "JetBrainsMono Nerd Font", style = "Bold", size = 14 },
				string = icon,
				drawing = true,
			},
			label = {
				font = { family = "JetBrainsMono Nerd Font", style = "Bold", size = 14 },
				string = string.format("%s, %s", data.location.region, data.location.country),
			},
			drawing = true,
		})
		sbar.add("item", "weather.condition", {
			position = "popup." .. weather.name,
			align = "center",
			width = popup_width,
			label = {
				font = { family = "JetBrainsMono Nerd Font", style = "Bold", size = 12 },
				string = string.format("%s", data.current.condition.text),
				y_offset = 10,
			},
			drawing = true,
		})

		local current_time = os.time()
		local current_hour = os.date("%H", current_time)

		for day_index, day_item in pairs(data.forecast.forecastday) do
			local display_date = "Today"
			if day_index == 2 then
				display_date = "Tomorrow"
			elseif day_index == 3 then
				local two_days_later = os.time() + (2 * 24 * 60 * 60)
				display_date = tostring(os.date("%A", two_days_later))
			end
			local day_icon = get_icon(day_item.day.condition.code, day_item.day.is_day)
			sbar.add("item", "weather.day." .. day_index, {
				position = "popup." .. weather.name,
				icon = {
					font = { family = "JetBrainsMono Nerd Font", style = "Bold", size = 12 },
					string = day_icon,
					drawing = true,
				},
				label = {
					font = { family = "JetBrainsMono Nerd Font", style = "Bold", size = 12 },
					string = string.format(
						"%s: 􀄨%s°C 􀄩%s°C",
						display_date,
						math.floor(day_item.day.maxtemp_c),
						math.floor(day_item.day.mintemp_c)
					),
					width = popup_width,
					align = "left",
				},
				drawing = true,
			})

			for hourly_index, hourly_item in ipairs(day_item.hour) do
				local hourly_icon = get_icon(hourly_item.condition.code, hourly_item.is_day)

				local dateString = hourly_item.time
				local pattern = "(%d+)-(%d+)-(%d+) (%d+):(%d+)"
				local year, month, day, hour, minute, second = dateString:match(pattern)
				local timestamp = os.time({
					year = year,
					month = month,
					day = day,
					hour = hour,
					min = minute,
					sec = second,
				})

				if
						hour == "00"
						or hour == "03"
						or hour == "06"
						or hour == "09"
						or hour == "12"
						or hour == "15"
						or hour == "18"
						or hour == "21"
				then
					if (day_index == 1 and hour >= current_hour) or day_index ~= 1 then
						sbar.add("item", "weather.day." .. day_index .. ".hourly." .. hourly_index, {
							position = "popup." .. weather.name,
							width = popup_width,
							icon = {
								font = { family = "JetBrainsMono Nerd Font", style = "Bold", size = 13 },
								string = hourly_icon,
							},
							label = {
								font = { family = "JetBrainsMono Nerd Font", style = "Regular", size = 12 },
								string = string.format(
									"%s | %s°C |  %s%%",
									os.date("%H:%M", timestamp),
									math.floor(hourly_item.temp_c),
									math.floor(hourly_item.humidity)
								),
							},
							drawing = true,
						})
					end
				end
			end
		end
	end)
end

weather:subscribe({ "forced", "routine", "system_woke" }, function(_)
	toggle_weather()
end)

weather:subscribe("mouse.clicked", function(_)
	weather:set({ popup = { drawing = "toggle" } })
end)

weather:subscribe("mouse.exited.global", function()
	weather:set({ popup = { drawing = false } })
end)
