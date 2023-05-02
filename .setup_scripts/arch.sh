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

	if [[ "$OS" == "Arch Linux" || "$OS" == "Manjaro Linux" ]]; then
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

	elif [[ "$OS" == "Darwin" ]]; then
		echo "Installing brew..."
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

		echo "Installing brew cask..."
		brew tap homebrew/cask

		brew upgrade

		# CLI Tools
		PROD=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n') || true

		if [[ ! -z "$PROD" ]]; then
			softwareupdate -i "$PROD" --verbose
		fi

		# Utilities
		brew install coreutils
		brew install gnu-sed
		brew install gnu-tar
		brew install gnu-indent
		brew install gnu-which

		brew install findutils

		# Dev Tools
		echo "Installing development tools..."
		brew install docker
		brew install git
		brew install --cask visual-studio-code
		brew install fish
		brew install neovim
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

	if
		[[ "$OS" == "Arch Linux" || "$OS" == "Manjaro Linux" ]]
	then
		# Install dependencies
		sudo pacman -S fish fzf tmux starship --needed

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

	elif
		[[ "$OS" == "Darwin" ]]
	then
		echo " TODO: Check if this works for Mac"

	fi

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

	if [[ "$OS" == "Arch Linux" || "$OS" == "Manjaro Linux" ]]; then
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

	elif [[ "$OS" == "Darwin" ]]; then
		echo "TODO: This seems nice - https://github.com/ianyh/Amethyst "

	fi
}

install_fonts() {
	clear

	if [[ "$OS" == "Arch Linux" || "$OS" == "Manjaro Linux" ]]; then
		echo -e "\n=> ${BOLD}${GREEN}Installing fonts${NONE} \n"

		for font in "$HOME"/Documents/Github/config_files/patched\ fonts/fonts/*; do
			sudo cp "$font" /usr/share/fonts/
			echo "installed $font"
		done
		echo -e "\nBuilding font cache..."
		sudo fc-cache

	elif [[ "$OS" == "Darwin" ]]; then
		open "$HOME"/Documents/Github/config_files/patched\ fonts/fonts/*
	fi

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

	if [[ "$OS" == "Arch Linux" || "$OS" == "Manjaro Linux" ]]; then
		sudo pacman -S python python-pip --needed --noconfirm
	elif [[ "$OS" == "Darwin" ]]; then
		brew install python
	fi

	# LSP Stuff
	echo -e "\n=> ${CYAN}LSPs:${NONE}"
	if [[ "$OS" == "Arch Linux" || "$OS" == "Manjaro Linux" ]]; then
		pip install yapf
		pip install pyright
		pip install flake8
	elif [[ "$OS" == "Darwin" ]]; then
		reset
		pip3 install yapf
		pip3 install pyright
		pip3 install flake8
	fi

	# Lua
	echo -e "\n=> ${BOLD}${GREEN}Installing lua stuff${NONE} \n"

	if [[ "$OS" == "Arch Linux" || "$OS" == "Manjaro Linux" ]]; then
		sudo pacman -S lua --needed --noconfirm
	elif [[ "$OS" == "Darwin" ]]; then
		brew install lua
	fi

	# LSP Stuff
	echo -e "\n=> ${CYAN}LSPs:${NONE}"
	if [[ "$OS" == "Arch Linux" || "$OS" == "Manjaro Linux" ]]; then
		sudo pacman -S stylua --needed --noconfirm
	elif [[ "$OS" == "Darwin" ]]; then
		brew install stylua
	fi

	# Shell
	echo -e "\n=> ${BOLD}${GREEN}Installing shell stuff${NONE} \n"
	if [[ "$OS" == "Arch Linux" || "$OS" == "Manjaro Linux" ]]; then
		sudo pacman -S zsh --needed --noconfirm
	fi

	# LSP Stuff
	echo -e "\n=> ${CYAN}LSPs:${NONE}"
	if [[ "$OS" == "Arch Linux" || "$OS" == "Manjaro Linux" ]]; then
		sudo pacman -S shfmt --needed --noconfirm
		if ! hash 2>/dev/null shellcheck; then
			yay -S shellcheck-bin
			npm i -g bash-language-server
		fi
	elif [[ "$OS" == "Darwin" ]]; then
		echo "TODO: Figure this out for Mac"
		npm i -g bash-language-server
	fi

	# Stuff for other languages
	echo -e "\n=> ${BOLD}${GREEN}Installing stuff for other languages${NONE} \n"
	if hash 2>/dev/null apt; then
		sudo snap install shfmt
		sudo apt install zsh gcc cmake clang default-jre default-jdk astyle build-essentials pkg-config libssl-dev
	elif hash 2>/dev/null pacman; then
		sudo pacman -S gcc cmake clang jdk-openjdk jre-openjdk astyle python --needed --noconfirm
	elif [ "Darwin" == "$(uname -s)" ]; then
		brew install shfmt astyle
	fi

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
