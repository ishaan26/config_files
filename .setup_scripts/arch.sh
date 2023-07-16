#!/bin/bash

STD='\033[0;0;39m'
NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

pause() {
	read -p "$*"
}

##################################
# Install Functions
##################################

install_packages() {

	clear
	echo -e "\n=> ${BOLD}${GREEN}Installing packages${NONE} \n"

	# Update
	sudo pacman -Syyu

	# Install basic packages
	sudo pacman -S --needed git \
		base-devel \
		inetutils \
		net-tools \
		neovim \
		zsh

	# Install yay
	if ! hash yay 2>/dev/null; then
		mkdir -p "$HOME"/Documents/Github/OtherGits
		cd "$HOME"/Documents/Github/OtherGits
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si
	fi

	echo -e "\nAll Done\n"
	pause "Press [Enter] to contiunue to main menu"
	clear
}

install_shell() {

	if ! hash yay 2>/dev/null; then
		echo -n "Please install packages first\n"
		exit
	fi

	clear

	echo -e "\n=> ${BOLD}${GREEN}Installing and setting up shell stuff${NONE} \n"

	# Install dependencies
	sudo pacman -S fish fzf tmux starship lolcat --needed

	# Linking all .config files
	for file in "$HOME"/Documents/Github/config_files/.config/*; do
		filename="$(basename "$file")"
		destination="$HOME"/.config/$filename
		if [ ! -L "$destination" ]; then
			ln -s "$file" "$destination"
			echo "Linked $filename"
		else
			echo "$filename already exists, skipping!"
		fi
	done

	# Link files outside .config folder
	ln -sf "$HOME"/Documents/Github/config_files/.tmux.conf "$HOME"/.tmux.conf
	ln -sf "$HOME"/Documents/Github/config_files/.gitconfig "$HOME"/.gitconfig

	echo -e "\nAll Done\n"
	pause "Press [Enter] to contiunue to main menu"
	clear
}

install_wm() {

	if ! hash fish 2>/dev/null; then
		echo -n "Please install shell first\n"
		exit
	fi

	clear

	echo -e "\n=> ${BOLD}${GREEN}Installing bspwm${NONE} \n"
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
		lxappearance \
		xorg-xrandr \
		alacritty

	# Install bspwm
	sudo pacman -S --noconfirm bspwm
	sudo pacman -S --noconfirm sxhkd

	# Install rofi
	sudo pacman -S rofi

	# Install Polybar
	yay -S polybar

	# Install Picom
	yay -S picom-jonaburg-git

	for file in $HOME/Documents/Github/config_files/.config/*; do
		filename="$(basename "$file")"
		# TODO: Exclude the already existing files.
		ln -s $HOME/Documents/Github/config_files/.config/"$filename" "$HOME"/.config/
		echo "Linked $filename"
	done

	echo -e "\nPlease reboot"

	pause "Press [Enter] to contiunue to main menu"

}

install_fonts() {
	clear

	echo -e "\n=> ${BOLD}${GREEN}Installing fonts${NONE} \n"

	for font in "$HOME"/Documents/Github/config_files/patched\ fonts/nerd-fonts/My\ Fonts/*; do
		sudo cp "$font" /usr/share/fonts/
		echo "installed $font"
	done
	echo -e "\nBuilding font cache..."
	sudo fc-cache

	echo -e "\nAll Done\n"
	pause "Press [Enter] to continue to main menu"
}

install_language_tools() {
	clear

	# Rust
	echo -e "\n=> ${BOLD}${GREEN}Installing rust toolchain${NONE} \n"
	if hash rustup &>/dev/null; then
		echo "rust is already installed"
	else
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	fi

	# JavaScript
	# Node
	echo -e "\n=> ${BOLD}${GREEN}Installing javascript stuff${NONE} \n"
	if type nvm &>/dev/null; then
		echo "Node version manager is already installed"
	else
		echo -e "=> ${CYAN}Node Version Manager:${NONE}"
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
		source "$HOME"/.nvm/nvm.sh
		nvm install node
	fi

	# LSP Stuff
	echo -e "\n=> ${CYAN}LSPs:${NONE}"
	npm i -g prettier eslint vue-language-server
	yay -S vscode-html-languageserver bash-language-server vscode-json-languageserver

	# Python
	# pip
	echo -e "\n=> ${BOLD}${GREEN}Installing python stuff${NONE} \n"

	sudo pacman -S python python-pip --needed --noconfirm

	# LSP Stuff
	echo -e "\n=> ${CYAN}LSPs:${NONE}"
	pip install yapf
	pip install pyright
	pip install flake8
	# Lua
	echo -e "\n=> ${BOLD}${GREEN}Installing lua stuff${NONE} \n"

	sudo pacman -S lua --needed --noconfirm

	# LSP Stuff
	echo -e "\n=> ${CYAN}LSPs:${NONE}"
	sudo pacman -S stylua --needed --noconfirm

	# Shell
	echo -e "\n=> ${BOLD}${GREEN}Installing shell stuff${NONE} \n"
	sudo pacman -S zsh --needed --noconfirm
	# LSP Stuff
	echo -e "\n=> ${CYAN}LSPs:${NONE}"
	sudo pacman -S shfmt --needed --noconfirm
	if ! hash 2>/dev/null shellcheck; then
		yay -S shellcheck-bin
		npm i -g bash-language-server
	fi

	# Stuff for other languages
	echo -e "\n=> ${BOLD}${GREEN}Installing stuff for other languages${NONE} \n"
	sudo pacman -S gcc cmake clang jdk-openjdk jre-openjdk astyle python --needed --noconfirm

	echo -e "\nAll Done\n"
	pause "Press [Enter] to contiunue to main menu"
	clear
}

install_cargo_packages() {

	echo -e "\n=> ${BOLD}${GREEN}Installing cargo packages${NONE} \n"

	if ! hash rustup &>/dev/null; then
		echo -n "Please install language tools first\n"
		exit
	fi

	cargo install lsd \
		onefetch \
		bat \
		procs \
		ripgrep \
		mdbook \
		du-dust \
		fd-find \
		hyperfine \
		tealdeer \
		viu \
		git-delta \
		gping \
		hexyl \
		bottom \
		zoxide \
		cargo-outdated \
		cargo-cache \
		cargo-update \
		cargo-watch \
		cargo-tree \
		cargo-audit \
		cargo-nextest \
		gptcommit \
		topgrade

	cargo install \
		tokei --features all

	# Install bat-extras
	mkdir -p $HOME/Documents/Github/OtherGits/
	cd $HOME/Documents/Github/OtherGits/
	git clone https://github.com/eth-p/bat-extras.git
	cd bat-extras
	sudo ./build.sh --install --manuals

	pause "Press [Enter] to contiunue to main menu"
}
