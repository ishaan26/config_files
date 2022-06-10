#!/usr/bin/env bash

clear

SCRIPT_DIR="$(dirname "$0")"

cd "${SCRIPT_DIR}"
source ./common.sh

echo -e "\n=> ${BOLD}${GREEN}Installing packages${NONE} \n"

# Update
sudo pacman -Syyu

# Install basic packages
sudo pacman -S --needed git \
	base-devel \
	inetutils \
	net-tools \
	neovim \
	zsh \
	vlc

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
