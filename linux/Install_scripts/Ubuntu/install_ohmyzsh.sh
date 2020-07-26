#!/bin/bash

clear

SCRIPT_DIR="$(dirname "$0")"


cd $SCRIPT_DIR
source ../common.sh

# Check System as the script only works on Ubintu 20.04 based OSs
check_os # Produces $OS and $VER from common.sh

if [[ "$OS" == "Pop!_OS" || "$OS" == "Ubuntu" ]]; then
    echo ""
else 
    echo "Scripts is not for $OS"
    exit
fi

if [[ "$VER" != "20.04" ]]; then
    echo "\n Script is not tested on version $VER"
    pause "Press [Enter] still proceed"
fi

# Install Dependencies
sudo apt install zsh zsh-doc curl wget neofetch python3 git font-manager


# Install and Setup Scripts

cd ~
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

pause "Press [Enter] to contiunue to main menu"
