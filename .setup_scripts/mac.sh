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

	echo -e "\n-> ${UNDERLINE}Installing brew...${NONE}\n"
	if test ! "$(which brew)"; then
		echo "Installing homebrew..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	else
		echo "Homebrew already installed."
	fi

	echo -e "\n-> ${UNDERLINE}Installing brew cask...${NONE}\n"
	brew tap homebrew/cask

	echo -e "\n-> ${UNDERLINE}Doind a brew update...${NONE}\n"
	brew update
	brew upgrade

	# CLI Tools
	echo -e "\n-> ${UNDERLINE}Installing CLI Tools...${NONE}\n"
	PROD=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n') || true

	if [[ -n "$PROD" ]]; then
		softwareupdate -i "$PROD" --verbose
	fi

	# Utilities
	echo -e "\n-> ${UNDERLINE}Installing Utilities...${NONE}\n"
	brew install coreutils
	brew install gnu-sed
	brew install gnu-tar
	brew install gnu-indent
	brew install gnu-which

	brew install findutils

	# Dev Tools
	echo -e "\n-> ${UNDERLINE}Installing Dev Tools...${NONE}\n"
	brew install docker
	brew install git
	brew install --cask visual-studio-code
	brew install fish
	brew install neovim

	echo -e "\nAll Done\n"
	pause "Press [Enter] to contiunue to main menu"
	clear
}

install_shell() {

	if ! hash brew 2>/dev/null; then
		echo -n "Please install packages first\n"
		exit
	fi

	clear

	echo -e "\n=> ${BOLD}${GREEN}Installing and setting up shell stuff${NONE} \n"

	# Install dependencies
	echo -e "-> ${UNDERLINE}Installing dependencies...${NONE}\n"
	brew install fish
	brew install fzf
	brew install tmux
	brew install starship
	brew install figlet
	brew install lolcat
	brew install --cask fig

	# Linking all .config files
	echo -e "-> ${UNDERLINE}Installing config files...${NONE}\n"
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

	# Setup astro nvim
	git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
	ln -sf $HOME/Documents/Github/config_files/astronvim_config/user $HOME/.config/nvim/lua/

	echo -e "\nAll Done\n"
	pause "Press [Enter] to contiunue to main menu"
	clear
}

install_fonts() {
	clear

	echo -e "\n=> ${BOLD}${GREEN}Installing fonts${NONE} \n"
	open "$HOME"/Documents/Github/config_files/patched\ fonts/nerd-fonts/My\ Fonts/*

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
		brew install node
		brew install npm
	fi

	# LSP Stuff
	echo -e "\n=> ${CYAN}LSPs:${NONE}"
	npm i -g prettier eslint vue-language-server

	# Python
	echo -e "\n=> ${BOLD}${GREEN}Installing python stuff${NONE} \n"
	brew install python

	# LSP Stuff
	echo -e "\n=> ${CYAN}LSPs:${NONE}"
	pip3 install yapf
	pip3 install pyright
	pip3 install flake8

	# Lua
	echo -e "\n=> ${BOLD}${GREEN}Installing lua stuff${NONE} \n"
	brew install lua

	# LSP Stuff
	echo -e "\n=> ${CYAN}LSPs:${NONE}"
	brew install stylua

	# LSP Stuff
	echo -e "\n=> ${CYAN}LSPs:${NONE}"
	npm i -g bash-language-server

	# Stuff for other languages
	echo -e "\n=> ${BOLD}${GREEN}Installing stuff for other languages${NONE} \n"
	brew install shfmt astyle

	echo -e "\nAll Done\n"
	pause "Press [Enter] to contiunue to main menu"
	clear
}
