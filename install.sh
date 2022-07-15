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

##################################
# Check OS
##################################

if [ -f /etc/os-release ]; then
	# freedesktop.org and systemd
	. /etc/os-release
	OS=$NAME
	VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
	# linuxbase.org
	OS=$(lsb_release -si)
	VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
	# For some versions of Debian/Ubuntu without lsb_release command
	. /etc/lsb-release
	OS=$DISTRIB_ID
	VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
	# Older Debian/Ubuntu/etc.
	OS=Debian
	VER=$(cat /etc/debian_version)
else
	# Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
	OS=$(uname -s)
	VER=$(uname -r)
fi

if [[ "$OS" == "Arch Linux" || "$OS" == "Manjaro Linux" ]]; then
	echo ""
else
	echo "Scripts is not for $OS"
	exit
fi

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
			zsh \

		# Install yay
		if ! hash yay 2>/dev/null; then
			mkdir -p "$HOME"/Documents/Github/OtherGits
			cd "$HOME"/Documents/Github/OtherGits
			git clone https://aur.archlinux.org/yay.git
			cd yay
			makepkg -si
		fi

	elif [[ "$OS" == "Darwin" ]]; then
		echo " TODO: write install packages script for Mac"

	fi
}

install_shell() {

	clear
	echo -e "\n=> ${BOLD}${GREEN}Installing and setting up shell stuff${NONE} \n"

	if [[ "$OS" == "Arch Linux" || "$OS" == "Manjaro Linux" ]]; then
		# Install dependencies
		sudo pacman -S zsh fzf --needed

		# Install Oh my zsh
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch

		# Install custom Plugins
		echo -e "\nInstalling zsh syntax highlighting"
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

		echo -e "\nInstalling zsh autosuggestions"
		git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

		echo -e "\nInstalling Powerlevel10k"
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

		# Link config files
		rm $HOME/.zshrc
		ln -sf $HOME/Documents/Github/config_files/.zshrc $HOME/.zshrc
		ln -sf $HOME/Documents/Github/config_files/.aliases.sh $HOME/.aliases.sh
		ln -sf $HOME/Documents/Github/config_files/.p10k.zsh $HOME/.p10k.zsh
		ln -sf $HOME/Documents/Github/config_files/.tmux.conf $HOME/.tmux.conf
		ln -sf $HOME/Documents/Github/config_files/.gitconfig $HOME/.gitconfig


		# vim and neovim setup
		ln -sf $HOME/Documents/Github/config_files/.vimrc $HOME/.vimrc
		ln -sf $HOME/Documents/Github/config_files/.config/nvim $HOME/.config/nvim

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
			lxappearance

		# Install bspwm
		sudo pacman -S --noconfirm bspwm
		sudo pacman -S --noconfirm sxhkd

		# Install rofi
		sudo pacman -S rofi

		# Install Polybar
		yay -S polybar

		# Install Picom
		# TODO

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
	npm i -g prettier eslint

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
		echo -n "Please install language tools first\n"\
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
		cargo-outdated \
		cargo-cache \
		cargo-update \
		cargo-watch \
		cargo-tree \
		cargo-audit \
		cargo-nextest

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

clear
# function to display menus
show_menus() {
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " I N S T A L L - S T U F F"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	if [[ "$OS" == "Arch Linux" || "$OS" == "Manjaro Linux" ]]; then
		echo "For $OS"
	elif [[ "$OS" == "Darwin" ]]; then
		echo "For MacOs"
	fi
	echo ""
	echo "1. Install Packages"
	echo "2. Setup Shell"
	echo "3. Install and setup window manager"
	echo "4. Install Fonts from patched fonts folder"
	echo "5. Install Languge Tools"
	echo "6. Install Cargo Packages"
	echo "7. Exit"
}

read_options() {
	local choice
	read -p "Enter choice [1 - 7]: " choice
	case $choice in
	1) install_packages ;;
	2) install_shell ;;
	3) install_wm ;;
	4) install_fonts ;;
	5) install_language_tools ;;
	6) install_cargo_packages ;;
	7) exit 0 ;;
	*) echo -e "${RED}Please select a valid option${STD}" && sleep 1 ;;
	esac
}

while true; do
	clear
	show_menus
	read_options
done
