#!/usr/bin/env bash

clear

SCRIPT_DIR="$(dirname "$0")"


cd $SCRIPT_DIR
source ../common.sh

# Check System as the script only works on Ubintu 20.04 based OSs
check_os # Produces $OS and $VER from common.sh

if [[ "$OS" == "Fedora" ]]; then
    echo ""
else 
    echo "Scripts is not for $OS"
    exit
fi

if [[ "$VER" != "32" ]]; then
    echo "\nScript is not tested on version $VER"
    pause "Press [Enter] still proceed"
fi

check_root # Checks sudo privlages of the shell from common.sh


cd ~
echo -e "\nInstalling zsh syntax highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

clear
echo -e "\nInstalling Powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

pause "Press [Enter] to continue setting up config files"
cd ~
rm .zshrc
ln -s ~/Documents/Github/config_files/linux/.zshrc
ln -s ~/Documents/Github/config_files/linux/.fedora_aliases .aliases
ln -s ~/Documents/Github/config_files/.vimrc
ln -s ~/Documents/Github/config_files/.p10k.zsh

echo "\nAll Done"
pause "Press [Enter] to continue to main menu"