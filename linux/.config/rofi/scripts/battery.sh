#!/usr/bin/env bash

rofi_command="rofi -theme themes/battery.rasi"

## Get data

BATTERY="$(acpi | awk -F ' ' '{print $4}' | tr -d \%,)"
CHARGE="$(acpi | awk -F ' ' '{print $3}' | tr -d \,)"

active=""
urgent=""

if [[ $CHARGE = *"Charging"* ]]; then
    active="-a 1"
    ICON_CHRG="    ﮣ"
    MSG=$CHARGE
elif [[ $CHARGE = *"Discharging"* ]]; then
    urgent="-u 1"
    ICON_CHRG="    ﮤ"
    MSG="Discharging"
elif [[ $CHARGE = * ]]; then
    active="-a 1"
    ICON_CHRG="    ﮣ"
    MSG="Full"
fi

ICON_PMGR=""

options="$ICON_CHRG\n$ICON_PMGR"

## Main
chosen="$(echo -e "$options" | $rofi_command -p "$BATTERY%" -dmenu $active $urgent -selected-row 0 -location 3 -yoffset 35 -xoffset -10)"
case $chosen in
$ICON_CHRG)
    if [[ $CHARGE == *"Charging"* ]]; then
        notify-send "Connected to power"
    elif [[ $CHARGE = *"Discharging"* ]]; then
        notify-send "Running on battery power"
    elif [[ $CHARGE = *"Full"* ]]; then
        notify-send "Battery is full"
    fi
    ;;
$ICON_PMGR)
    xfce4-power-manager-settings &
    ;;
esac
