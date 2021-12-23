#!/usr/bin/env bash

rofi_command='rofi -theme themes/screenshot.rasi -color-window "#222222, #222222, #b1b4b3"'

# Options
screen=""
area=""
window=""

# vars
DATE="$(date +%d-%b-%H_%M_%S)"
DEST_FOLDER="$(xdg-user-dir PICTURES)"

# Variable passed to rofi
options="$screen\n$area\n$window"

chosen="$(echo -e "$options" | $rofi_command -p '' -dmenu -selected-row 1 -location 5 -yoffset -50 -xoffset -1100)"
case $chosen in
$screen)
    sleep 1
    maim "$DEST_FOLDER"/"screen_$DATE".png && gwenview "$DEST_FOLDER"/"screen_$DATE".png &
    ;;
$area)
    maim -s "$DEST_FOLDER"/"area_$DATE".png && gwenview "$DEST_FOLDER"/"area_$DATE".png &
    ;;
$window)
    maim -st 9999999 "$DEST_FOLDER"/"window_$DATE".png && gwenview "$DEST_FOLDER"/"window_$DATE".png &
    ;;
esac
