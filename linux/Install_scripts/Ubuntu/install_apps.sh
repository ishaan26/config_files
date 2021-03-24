#!/usr/bin/env bash

clear

DOWNLOADS_LOCATION=~/Downloads
SCRIPT_DIR="$(dirname "$0")"

cd $SCRIPT_DIR
source ../common.sh

# Check System as the script only works on Ubintu 20.04 based OSs
check_os

if [[ "$OS" == "Pop!_OS" || "$OS" == "Ubuntu" ]]; then
    echo ""
else
    echo "Scripts is not for $OS"
    exit
fi

if [[ "$VER" != "20.04" ]]; then
    echo -e "\nThis Script is not tested on version $VER"
    pause "Press [Enter] still proceed"
fi


if ! sudo -nv 2>/dev/null; then
    echo 'Root privlages are required'
    sudo -v
fi

# Update
sudo apt update
sudo apt upgrade -y

cd $DOWNLOADS_LOCATION
# Install Essentials
sudo apt install -y vlc timeshift vim gdebi neofetch curl wget git

# Install Papirus Icon Pack
sudo add-apt-repository ppa:papirus/papirus -y
sudo apt-get update
sudo apt-get install papirus-icon-theme -y

# Install Flatpak
sudo apt install flatpak -y
sudo apt install gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        
# Install LibreOffice
sudo add-apt-repository ppa:libreoffice/libreoffice-7-0 -y
sudo apt install libreoffice -y
sudo apt install libreoffice-style-papirus -y
        
# Install VS Code
wget -O code.deb https://go.microsoft.com/fwlink/?LinkID=760868 -q --show-progress
sudo gdebi code.deb -n

# Install Google Chrome
wget -O google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -q --show-progress
sudo gdebi google-chrome.deb -n
        
# Install Mailspring
wget -O mailspring.deb https://updates.getmailspring.com/download?platform=linuxDeb -q --show-progress
sudo gdebi mailspring.deb -n        

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

# Install Alacritty
mkdir -p ~/Documents/Github/OtherGits
cd ~/Documents/Github/OtherGits

git clone https://github.com/alacritty/alacritty.git
cd alacritty

sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3
cargo build --release
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

sudo cp target/release/alacritty /usr/local/bin
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null

mkdir -p ${ZDOTDIR:-~}/.zsh_functions
echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> ${ZDOTDIR:-~}/.zshrc
cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty

# Install Ulauncher 
sudo add-apt-repository ppa:agornostal/ulauncher -y
sudo apt install ulauncher -y

# Install Vundle
ln -sf ~/Documents/Github/config_files/.vimrc ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install nvm 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

# Install gh
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages -y
sudo apt install gh -y

# Install appimagelauncher
sudo add-apt-repository ppa:appimagelauncher-team/stable -y
sudo apt install appimagelauncher -y

# Install foliate
sudo add-apt-repository ppa:apandada1/foliate -y
sudp apt install foliate -y
