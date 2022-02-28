#!/usr/bin/env bash

clear

SCRIPT_DIR="$(dirname "$0")"

cd "${SCRIPT_DIR}"
source ../common.sh

check_os

if hash 2>/dev/null pacman; then
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

# Install basic packages
sudo pacman -S --needed git \
                        base-devel \
                        inetutils \
                        net-tools \
                        neovim \
                        zsh \
                        vlc \

# Install yay
if ! hash yay 2>/dev/null; then
    mkdir -p $HOME/Documents/Github/OtherGits
    cd $HOME/Documents/Github/OtherGits
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
fi

# Install pamac
if ! hash pamac 2>/dev/null; then
    yay -S --needed pamac-all
fi

# Vim setup
ln -sf $HOME/Documents/Github/config_files/.vimrc $HOME/.vimrc
ln -sf $HOME/Documents/Github/config_files/linux/.config/nvim $HOME/.config/nvim
