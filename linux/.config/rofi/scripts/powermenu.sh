#!/bin/bash

dir="$HOME/.config/rofi/themes/powermenu/"

rofi_command="rofi -theme $dir/theme.rasi"

# Options
shutdown=""
reboot=""
lock=""
suspend="⏼"
logout=""

# Confirmation
confirm_exit() {
    confirm_yes="Yes"
    confirm_no="No"
    confirm_options="$confirm_yes\n$confirm_no"
    echo -e $confirm_options | rofi -p "Are You Sure?" -dmenu -selected-row 1  \
        -theme $dir/confirm.rasi
}


uptime=$(uptime -p | sed -e 's/up //g')

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 1 -location 5)"
case $chosen in
$shutdown)
    ans=$(confirm_exit &)
    if [[ $ans == "Yes" ]]; then
        systemctl poweroff
    elif [[ $ans == "No" ]]; then
        exit 0
    fi
    ;;
$reboot)
    ans=$(confirm_exit &)
    if [[ $ans == "Yes" ]]; then
        systemctl reboot
    elif [[ $ans == "No" ]]; then
        exit 0
    fi
    ;;
$lock)
    ans=$(confirm_exit &)
    if [[ $ans == "Yes" ]]; then
        betterlockscreen -l
    elif [[ $ans == "No" ]]; then
        exit 0
    fi
    ;;
$suspend)
    ans=$(confirm_exit &)
    if [[ $ans == "Yes" ]]; then
        mpc -q pause
        amixer set Master mute
        systemctl suspend
    elif [[ $ans == "No" ]]; then
        exit 0
    fi
    ;;
$logout)
    ans=$(confirm_exit &)
    if [[ $ans == "Yes" ]]; then
        if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
            openbox --exit
        elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
            bspc quit
        elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
            i3-msg exit
        fi
    elif [[ $ans == "No" ]]; then
        exit 0
    fi
    ;;
esac
