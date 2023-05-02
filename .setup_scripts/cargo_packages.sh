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

install_cargo_packages() {

	echo -e "\n=> ${BOLD}${GREEN}Installing cargo packages${NONE} \n"

	if ! hash rustup &>/dev/null; then
		echo -n "Please install language tools first \n"
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
