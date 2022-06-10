#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"

RED='\033[0;41;30m'
STD='\033[0;0;39m'

cd "${SCRIPT_DIR}" 
source ./common.sh

# Check System as the script only works on Ubintu 20.04 based OSs
check_os # Produces $OS and $VER from common.sh

if [[ "$OS" == "Arch Linux" || "$OS" == "Manjaro Linux" ]]; then
	echo ""
else
	echo "Scripts is not for $OS"
	exit
fi

# function to display menus
show_menus() {
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " I N S T A L L - S T U F F"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "For $OS"
	echo ""
	echo "1. Install Packages"
	echo "2. Setup Shell"
	echo "3. Install and setup bspwm"
	echo "4. Install Fonts from patched fonts folder"
	echo "5. Exit"
}

read_options() {
	local choice
	read -p "Enter choice [1 - 5]: " choice
	case $choice in
	1) bash "$SCRIPT_DIR/packages.sh" ;;
	2) bash "$SCRIPT_DIR/shell.sh" ;;
	3) bash "$SCRIPT_DIR/bspwm.sh" ;;
	4) bash "$SCRIPT_DIR/fonts.sh" ;;
	5) exit 0 ;;
	*) echo -e "${RED}Please select a valid option${STD}" && sleep 1 ;;
	esac
}

while true; do
	show_menus
	read_options
done
