#!/usr/bin/env bash

sudo apt install i3 -y

i3-config-wizard

echo 'bindsym $mod+Shift+x exec i3lock' >> ~/.config/i3/config
