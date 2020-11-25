#!/usr/bin/env bash

rofi_command="rofi -theme themes/battery.rasi"

## Get data

BATTERY="$(acpi | awk -F ' ' '{print $4}' | tr -d \%,)"
CHARGE="$(acpi | awk -F ' ' '{print $3}' | tr -d \,)"

active=""
urgent=""

if [[ $CHARGE = *"Charging"* ]]; then
    active="-a 1"
    ICON_CHRG="ﮣ"  
    MSG=$CHARGE
elif [[ $CHARGE = *"Discharging"* ]]; then
    urgent="-u 1"
    ICON_CHRG="ﮤ"
    MSG="Discharging"
elif [[ $CHARGE = * ]]; then
    active="-a 1"
    ICON_CHRG="ﮣ"
    MSG="Full"
fi



# Discharging
#if [[ $CHARGE -eq 1 ]] && [[ $BATTERY -eq 100 ]]; then
#    ICON_DISCHRG=""
if [[ $BATTERY -ge 5 ]] && [[ $BATTERY -le 19 ]]; then
    ICON_DISCHRG=" "
elif [[ $BATTERY -ge 20 ]] && [[ $BATTERY -le 39 ]]; then
    ICON_DISCHRG=" "
elif [[ $BATTERY -ge 40 ]] && [[ $BATTERY -le 59 ]]; then
    ICON_DISCHRG=" "
elif [[ $BATTERY -ge 60 ]] && [[ $BATTERY -le 79 ]]; then
    ICON_DISCHRG=" "
elif [[ $BATTERY -ge 80 ]] && [[ $BATTERY -le 100 ]]; then
    ICON_DISCHRG=" "
fi

## Icons
ICON_PMGR=""

options="$ICON_DISCHRG\n$ICON_CHRG\n$ICON_PMGR"

## Main
chosen="$(echo -e "$options" | $rofi_command -p "$BATTERY%" -dmenu $active $urgent -selected-row 0 -location 3 -yoffset 35 -xoffset -10)"
case $chosen in
    $ICON_CHRG)
        ;;
    $ICON_DISCHRG)
        ;;
    $ICON_PMGR)
        xfce4-power-manager-settings &
        ;;
esac
