#!/bin/bash

clear

SCRIPT_DIR="$(dirname "$0")"

cd "${SCRIPT_DIR}"
source ../common.sh

check_os

if hash 2>/dev/null zypper; then
    echo ""
else
    echo "Scripts is not for $OS"
    exit
fi

if ! sudo -nv 2>/dev/null; then
    echo 'Root privlages are required'
    sudo -v
fi

check_root # Checks sudo privlages of the shell from common.sh
clear

# Install dependencies
sudo zypper alsa-utils \
    brightnessctl \
    feh \
    dunst \
    acpi \
    maim \
    pavucontrol-qt \
    network-manager-applet \
    polkit-gnome \
    python-dbus \
    qt5ct \
    lxappearance

# Install bspwm
sudo pacman -S --noconfirm bspwm
sudo pacman -S --noconfirm sxhkd

# Install rofi
sudo pacman -S rofi

# Install Polybar
yay -S polybar

# Install Compton
yay -S compton-tryone-git

cd $HOME/.config
tell_location

for file in $HOME/Documents/Github/config_files/linux/.config/*; do
    filename="$(basename "$file")"
    ln -s $HOME/Documents/Github/config_files/linux/.config/"$filename" .
    echo "Linked $filename"
done

echo -e "\nPlease reboot"

pause "Press [Enter] to contiunue to main menu"
