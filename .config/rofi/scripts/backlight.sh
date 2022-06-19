#!/usr/bin/env bash

rofi_command="rofi -theme themes/backlight.rasi"

## Get Brightness
VAR="$(brightnessctl i | grep "[0-9]*%" -o)"
BLIGHT="$(printf "%.0f\n" "$VAR")"

## Icons
ICON_UP=""
ICON_DOWN=""
ICON_MAX=""

options="$ICON_UP\n$ICON_DOWN\n$ICON_MAX"

## Main
chosen="$(echo -e "$options" | $rofi_command -p "$BLIGHT%" -dmenu -selected-row 1 -location 3 -yoffset 35 -xoffset -150)"
case $chosen in
$ICON_UP)
    brightnessctl set +10% "$ICON_UP" >/dev/null
    ;;
$ICON_DOWN)
    brightnessctl set 10%- "$ICON_DOWN" >/dev/null
    ;;
$ICON_MAX)
    brightnessctl set 1500 "$ICON_MAX" >/dev/null
    ;;
esac
