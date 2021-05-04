#!/bin/bash

clear

SCRIPT_DIR="$(dirname "$0")"

cd $SCRIPT_DIR
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

# Install i3-gaps
sudo pacman -S i3-gaps

# Install Rofi
yay -S rofi-git

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
