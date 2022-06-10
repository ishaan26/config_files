#!/bin/bash

# Font Colors
NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

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
echo -e "=> ${CYAN}Node Version Manager:${NONE}"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source "$HOME"/.nvm/nvm.sh
nvm install node

# LSP Stuff
echo -e "\n=> ${CYAN}LSPs:${NONE}"
npm i -g prettier eslint

# Python
# pip
echo -e "\n=> ${BOLD}${GREEN}Installing python stuff${NONE} \n"
sudo pacman -S python python-pip --needed --noconfirm

# LSP Stuff
echo -e "\n=> ${CYAN}LSPs:${NONE}"
pip install pyright
pip install yapf
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
fi
npm i -g bash-language-server

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
