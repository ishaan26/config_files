#!/bin/bash

clear

SCRIPT_DIR="$(dirname "$0")"

cd "${SCRIPT_DIR}"
source ../common.sh

# Check System as the script only works on Ubintu 20.04 based OSs
check_os # Produces $OS and $VER from common.sh

if [[ "$OS" == "Arch Linux" ]]; then
    echo ""
else
    echo "Scripts is not for $OS"
    exit
fi

check_root # Checks sudo privlages of the shell from common.sh
clear

# Install dependencies
sudo pacman -S --needed --noconfirm alsa-utils \
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
