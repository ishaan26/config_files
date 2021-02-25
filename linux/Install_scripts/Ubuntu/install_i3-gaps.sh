#!/bin/bash

clear

SCRIPT_DIR="$(dirname "$0")"
GIT_CLONE_DIR="/home/$(whoami)/Documents/Github/OtherGits"


cd $SCRIPT_DIR
source ../common.sh

# Check System as the script only works on Ubintu 20.04 based OSs
check_os # Produces $OS and $VER from common.sh

if [[ "$OS" == "Pop!_OS" || "$OS" == "Ubuntu" ]]; then
    echo ""
else 
    echo "Scripts is not for $OS"
    exit
fi

if [[ "$VER" != "20.04" ]]; then
    echo "\nScript is not tested on version $VER"
    pause "Press [Enter] still proceed"
fi

check_root # Checks sudo privlages of the shell from common.sh
clear

mkdir -p "$GIT_CLONE_DIR"
cd "$GIT_CLONE_DIR"
tell_location

pause "Press [Enter] to continue installing dependencies"

echo -e "\nInstalling dependencies\n"

sudo apt install curl cmake libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
    libxcb-util0-dev libxcb-icccm4-dev libyajl-dev meson brightnessctl\
    libstartup-notification0-dev xbacklight libxcb-randr0-dev \
    libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
    libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
    autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev gcc make dh-autoreconf libxcb-keysyms1-dev \
    libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev \
    libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev \
    libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev -y

sudo apt install libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev build-essential \
    git cmake cmake-data pkg-config python3-sphinx bison flex pavucontrol\
    libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev \
    python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev \
    libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev \
    libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev \
    libnl-genl-3-dev fonts-materialdesignicons-webfont kitty indent libanyevent-i3-perl \
    libx11-dev libxcomposite-dev libxdamage-dev libxfixes-dev libxrandr-dev \
    libxinerama-dev libconfig-dev libdbus-1-dev mesa-common-dev asciidoc lxappearance \
    gtk-chtheme qt5ct freeglut3-dev feh jq libxcb-render0-dev libffi-dev python-dev python-cffi -y

sudo apt install viewnior scrot mpc acpi dunst filelight texinfo policykit-1-gnome\
    gnome-disk-utility gnome-system-monitor aptitude texinfo dolphin konsole \
    maim gwenview -y

# Rofi dependencies
sudo aptitude install libjpeg-dev librsvg2-dev libglib2.0-dev -y

pause "Press [Enter] to install i3-gaps"
clear

echo "Installing i3-gaps"
sudo add-apt-repository ppa:dennis-kruyt/ricebuilder
sudo apt install i3-gaps
echo -e "\ni3-gaps installed"
pause "Press [Enter] to continue"
clear

echo "Installing Polybar"
sudo apt install polybar
echo -e "\nPolybar installed"
pause "Press [Enter] to continue"
clear

echo -e "Installing compton-tryone"
git clone https://github.com/tryone144/compton
cd compton
make
make docs
sudo make install
cd "$GIT_CLONE_DIR"
echo -e "\ncompton-tryone installed"
pause "Press [Enter] to continue"

echo -e "Installing rofi"
git clone --recursive https://github.com/DaveDavenport/rofi
cd rofi
meson setup build
ninja -C build
sudo ninja -C build install
cd "$GIT_CLONE_DIR"
echo -e "\nRofi installed"
pause "Press [Enter] to setup config files"


cd ~/.config
tell_location

for file in ~/Documents/Github/config_files/linux/.config/*; do
    filename="$(basename "$file")"
    ln -s ~/Documents/Github/config_files/linux/.config/"$filename" .
    echo "Linked $filename config files"
done

# permissions for scripts
chmod 755 ~/.config/rofi/scripts/*
chmod 755 ~/.config/polybar/scripts/*

echo -e "\nPlease reboot"

pause "Press [Enter] to contiunue to main menu"
