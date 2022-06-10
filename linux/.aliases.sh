#!/bin/bash

# Font stuff
NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

# Programs stuff
function update() {
	echo -e "\n=> ${BOLD}${GREEN}Updating packages${NONE} \n"
	if hash 2>/dev/null pacman; then
		yay
	elif hash 2>/dev/null apt; then
		sudo apt update -y && sudo apt upgrade -y
	fi

	echo -e "\n=> ${BOLD}${GREEN}Updating flatpaks${NONE} \n"
	sudo flatpak update -y

	echo -e "\n=> ${BOLD}${GREEN}Updating cartes${NONE} \n"
	cargo install-update -a

	echo -e "\n=> ${BOLD}${GREEN}Updating other stuff${NONE} \n"
	echo -e "=> ${CYAN}Rustup:${NONE}"
	rustup update
	echo -e "\n=> ${CYAN}Node Version Manager:${NONE}"
	nvm install --lts
	nvm install node

	echo -e "\n=> ${BOLD}${GREEN}Updating Github Directories${NONE}"
	echo -e "\n=> ${CYAN}config_files:${NONE}"
	git -C "$CF" pull
	echo -e "\n=> ${CYAN}Learning:${NONE}"
	git -C "$PJT" pull
	echo -e "\n=> ${CYAN}implementor:${NONE}"
	git -C "$RS" pull

	echo -e "\n=> ${BOLD}${GREEN}Updating neovim plugins${NONE}"
	nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
	echo -e "\n${BOLD}Done${NONE}!"
}


function zsh_colors() {
	for i in {0..255}; do
		printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
		if ((i == 15)) || ((i > 15)) && (((i - 15) % 6 == 0)); then
			printf "\n"
		fi
	done
}

function cf() {
	cd "$CF" || echo "Directory not available"
	if [[ $1 == "-f" ]]; then
		git fetch
	fi
}

function pjt() {
	cd "$PJT" || echo "Directory not available"
	if [[ $1 == "-f" ]]; then
		git fetch
	fi
}

function rs() {
	cd "$RS" || echo "Directory not available"
	if [[ $1 == "-f" ]]; then
		git fetch
	fi
}

#Git stuff
alias githistory="git log --oneline --graph --decorate --all"

function gitupload() {
	if [ -n "$1" ]; then
		git add .
		git commit -am "$1"
		git push
	else
		echo "Provide a commit message"
	fi

}

# Document stuff
function ocrall() {
	for i in ./*.pdf; do
		echo -e "\nRescannig $i"
		ocrmypdf --force-ocr "$i" "$i"
	done
}

function tex2word() {
	if [ -n "$1" ]; then
		if [[ -f "$1".tex ]]; then
			pandoc "$1".tex -o "$1".docx
			if [[ "$2" == "-o" ]]; then
				if [[ -n "$IS_WSL" || -n "$WSL_DISTRO_NAME" ]]; then
					explorer.exe "$1".docx
				elif [[ "$(uname -s)" == "Linux" ]]; then
					xdg-open "$1".docx &
				elif [[ "$(uname -s)" == "Darwin" ]]; then
					open "$1".docx
				fi
			fi
		else
			echo "No latex file found"
		fi
	else
		echo "Please provide a latex file"
	fi
}

# Custom Aliases
alias l="lsd -lah"
alias ll="lsd -lh"
alias ls="lsd"
alias tree="lsd --tree"
alias vim="nvim"
alias vimf='nvim "$(fzf --height 40% --reverse)"'
alias tk="tmux kill-session -a"
alias ta="tmux attach-session -t Hack"
alias myip="ip -4 addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}'"
