#!/usr/bin/env bash

## Dependencies
sudo apt install intel-gpu-tools
sudo apt install xbacklight pulseaudio playerctl

read -r -d '' MEDIA_CONF << EOF
\n
# Media and brightness controls
# Pulse Audio controls
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume 0 +5% #increase sound volume
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume 0 -5% #decrease sound volume
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute 0 toggle # mute sound

# Sreen brightness controls
bindsym XF86MonBrightnessUp exec xbacklight -inc 20 # increase screen brightness
bindsym XF86MonBrightnessDown exec xbacklight -dec 20 # decrease screen brightness

# Touchpad controls
bindsym XF86TouchpadToggle exec /some/path/toggletouchpad.sh # toggle touchpad

# Media player controls
bindsym XF86AudioPlay exec playerctl play
bindsym XF86AudioPause exec playerctl pause
bindsym XF86AudioNext exec playerctl next
bindsym XF86AudioPrev exec playerctl previous

EOF

echo -e "$MEDIA_CONF" >> ~/.config/i3/config

## xbacklight fix
sudo bash
fix_file='/etc/X11/xorg.conf'

read -r -d '' BRIGHT_FIX << EoF
Section "Device"
Identifier  "Card0"
Driver      "intel"
Option      "Backlight"  "NAME OF THE FOLDER"
EndSection
EoF


touch $fix_file

echo -e "$BRIGHT_FIX" >> /etc/X11/xorg.conf
exit
