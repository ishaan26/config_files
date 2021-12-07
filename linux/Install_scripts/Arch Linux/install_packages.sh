#!/usr/bin/env bash

clear

SCRIPT_DIR="$(dirname "$0")"

cd "${SCRIPT_DIR}"
source ../common.sh

# Check System as the script only works on Ubintu 20.04 based OSs
check_os

if [[ "$OS" == "Arch Linux" ]]; then
    echo ""
else
    echo "Scripts is not for $OS"
    exit
fi

if ! sudo -nv 2>/dev/null; then
    echo 'Root privlages are required'
    sudo -v
fi

# Update
sudo pacman -Syyu

# Install pacman packages
sudo pacman -S --needed - <./pkglist.txt

# Install yay
pacman -S --needed git base-devel

if ! hash 2>/dev/null; then
    mkdir -p $HOME/Documents/Github/OtherGits
    cd $HOME/Documents/Github/OtherGits
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
fi

cd "$HOME/Documents/Github/config_files/linux/Install_scripts/Arch Linux/"
# Install aur packages
yay -S --needed - <./pkglist_aur.txt
