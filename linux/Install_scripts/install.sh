#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"

RED='\033[0;41;30m'
STD='\033[0;0;39m'

cd $SCRIPT_DIR
source ./common.sh

# Check System as the script only works on Ubintu 20.04 based OSs
check_os # Produces $OS and $VER from common.sh

if [[ "$OS" == "Pop!_OS" || "$OS" == "Ubuntu" || "$OS" == "Fedora" ]]; then
    echo ""
else 
    echo "Scripts is not for $OS"
    exit
fi



# function to display menus
show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"	
	echo " I N S T A L L - S T U F F"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "For $OS"
    echo ""
	echo "1. Install Apps"
	echo "2. Install oh-my-zsh"
    echo "3. Setup oh-my-zsh"
    echo "4. Install and setup i3-gaps"
	echo "5. Install Fonts from patched fonts folder"
	echo "6. Exit"
}

read_options(){
	local choice
	read -p "Enter choice [ 1 - 6]: " choice
	case $choice in
		1) bash $SCRIPT_DIR/$OS/install_apps.sh ;;
		2) bash $SCRIPT_DIR/$OS/install_ohmyzsh.sh ;;
		3) bash $SCRIPT_DIR/$OS/setup_ohmyzsh.sh ;;
        4) bash $SCRIPT_DIR/$OS/install_i3-gaps.sh ;;
        5) install_fonts_common ;;
		6) exit 0 ;;
		*) echo -e "${RED}Please select a valid option${STD}" && sleep 1
	esac
}


while true
do
	show_menus
	read_options
done
