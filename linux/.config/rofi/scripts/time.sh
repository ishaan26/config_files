#!/bin/bash

dir="$HOME/.config/rofi/themes"
rofi_command="rofi -theme $dir/time.rasi"

## Get time and date
TIME="$(date +"%I:%M %p")"
DN=$(date +"%A")
MN=$(date +"%B")
DAY="$(date +"%d")"
MONTH="$(date +"%m")"
YEAR="$(date +"%Y")"

options="$DAY\n$MONTH\n$YEAR"

## Main
chosen="$(echo -e "$options" | $rofi_command -p "   $DN, $TIME" -dmenu selected-row 0 -location 3 -yoffset 35 -xoffset -700)"
case $chosen in
$DAY) gnome-calendar & ;;
$MONTH) gnome-calendar & ;;
$YEAR) gnome-calendar & ;;
esac
