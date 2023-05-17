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

if [[ "$OS" == "Arch Linux" || "$OS" == "Manjaro Linux" || "$OS" == "Darwin" ]]; then
	echo ""
else
	echo "This script is not made for $OS. Why in the world do you not use Arch?"
	exit
fi

pause() {
	read -p "$*"
}

source ./.setup_scripts/cargo_packages.sh

if [[ "$OS" == "Arch Linux" || "$OS" == "Manjaro Linux" ]]; then
	source ./.setup_scripts/arch.sh

	show_menus() {
		echo -e "${BOLD}――――――――――――――――――――――――――――――――――――"
		echo " I N S T A L L - S T U F F for $OS"
		echo -e "――――――――――――――――――――――――――――――――――――――${NONE}"
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

elif [[ "$OS" == "Darwin" ]]; then
	source ./.setup_scripts/mac.sh

	show_menus() {
		echo -e "${BOLD}${GREEN}―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
		cat << "EOF"
  _____           _        _ _             _____ _          __  __    __             __  __             ____      
 |_   _|         | |      | | |           / ____| |        / _|/ _|  / _|           |  \/  |           / __ \     
   | |  _ __  ___| |_ __ _| | |  ______  | (___ | |_ _   _| |_| |_  | |_ ___  _ __  | \  / | __ _  ___| |  | |___ 
   | | | '_ \/ __| __/ _` | | | |______|  \___ \| __| | | |  _|  _| |  _/ _ \| '__| | |\/| |/ _` |/ __| |  | / __|
  _| |_| | | \__ \ || (_| | | |           ____) | |_| |_| | | | |   | || (_) | |    | |  | | (_| | (__| |__| \__ \
 |_____|_| |_|___/\__\__,_|_|_|          |_____/ \__|\__,_|_| |_|   |_| \___/|_|    |_|  |_|\__,_|\___|\____/|___/
EOF
                                                                                                                  
		echo -e "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――${NONE}"
		echo ""
		echo "1. Install Packages"
		echo "2. Setup Shell"
		echo "3. Install Fonts from patched fonts folder"
		echo "4. Install Languge Tools"
		echo "5. Install Cargo Packages"
		echo "6. Exit"
		echo ""
	}

	read_options() {
		local choice
		read -p "Enter choice [1 - 6]: " choice
		case $choice in
		1) install_packages ;;
		2) install_shell ;;
		3) install_fonts ;;
		4) install_language_tools ;;
		5) install_cargo_packages ;;
		6) exit 0 ;;
		*) echo -e "${RED}Please select a valid option${STD}" && sleep 1 ;;
		esac
	}
fi

# function to display menus

while true; do
	clear
	show_menus
	read_options
done
