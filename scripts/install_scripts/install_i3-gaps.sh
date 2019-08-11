#!/usr/bin/env bash

## Dependencies
sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool automake libxcb-xrm-dev libxcb-shape0-dev

## Clone git repo
cd /tmp
git clone https://github.com/resloved/i3.git
cd i3
git checkout gaps && git pull

## Build and install
autoreconf --force --install
rm -rf build
mkdir build
cd build
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install

# ## add config
# read -r -d '' GAPS_CONF << EOM
# \n
# \n
# # Gaps config
# smart_gaps on
# gaps inner 20
#
# for_window [class="^.*"] border pixel 2
#
# EOM
#
# echo -e "$GAPS_CONF" >> ~/.config/i3/config
