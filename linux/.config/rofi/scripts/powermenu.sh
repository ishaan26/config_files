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
    rofi -dmenu -i -no-fixed-num-lines -p "Are You Sure? : " \
        -theme $dir/confirm.rasi
}

# Message
msg() {
    rofi -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
}

uptime=$(uptime -p | sed -e 's/up //g')

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 1 -location 5)"
case $chosen in
$shutdown)
    ans=$(confirm_exit &)
    if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
        systemctl poweroff
    elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
        exit 0
    else
        msg
    fi
    ;;
$reboot)
    ans=$(confirm_exit &)
    if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
        systemctl reboot
    elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
        exit 0
    else
        msg
    fi
    ;;
$lock)
    if [[ -f /usr/bin/i3lock ]]; then
        i3lock
    elif [[ -f /usr/bin/betterlockscreen ]]; then
        betterlockscreen -l
    fi
    ;;
$suspend)
    ans=$(confirm_exit &)
    if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
        mpc -q pause
        amixer set Master mute
        systemctl suspend
    elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
        exit 0
    else
        msg
    fi
    ;;
$logout)
    ans=$(confirm_exit &)
    if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
        if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
            openbox --exit
        elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
            bspc quit
        elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
            i3-msg exit
        fi
    elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
        exit 0
    else
        msg
    fi
    ;;
esac
