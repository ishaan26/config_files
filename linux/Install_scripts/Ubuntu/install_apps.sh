#!/usr/bin/env bash

clear

LOCATION=~/Downloads
SCRIPT_DIR="$(dirname "$0")"

UBUNTU_VERSION="20.04"

if ! [ "$LOCATION" ]; then
    echo "Please specify a directory as the argument"
    exit
fi

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
    echo "\n This Script is not tested on version $VER"
    pause "Press [Enter] still proceed"
fi


if ! sudo -nv 2>/dev/null; then
    echo 'Root privlages are required'
    sudo -v
fi


INSTALL_SOFTWARE=(
    'papirus' \
    'flatpak' \
    'libreoffice' \
    'vlc' \
    'timeshift'
    'sublimetext' \
    'etcher'
)

DOWNLOAD_SOFTWARE=(
    'vscode' \
    'google-chrome' \
    'simplenote' \
    'atom' \
    'gitkraken' \
    'mailspring' \
)

get_package_name() {
    local deb=$1
    
    pkg_name=$(dpkg-deb -I $deb | grep -Po "Package: \K[^ ]+")
}


check_if_pkg_installed() {
    local pkg=$1
    
    if [[ $(dpkg -l $pkg | grep -io desired) == 'Desired' ]]; then
        echo "$pkg is already installed"
        pkg_not_installed=false
    else
        pkg_not_installed=true
    fi
}


# Downloads:
question() {
    local app_name=$1
    echo -e "\nDo you want to download and install $app_name? [y/n]:"
    read answer
}


install_software() {
    cd $LOCATION
    
    local app_name=$1
    
    if [[ $app_name == 'papirus' ]]; then
        sudo add-apt-repository ppa:papirus/papirus
        sudo apt-get update
        sudo apt-get install papirus-icon-theme -y
        
    elif [[ $app_name == 'flatpak' ]]; then
        sudo apt install flatpak -y
        sudo apt install gnome-software-plugin-flatpak -y
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        
    elif [[ $app_name == 'libreoffice' ]]; then
        sudo add-apt-repository ppa:libreoffice/ppa
        sudo apt install libreoffice -y
        sudo apt install libreoffice-style-papirus -y
        
    elif [[ $app_name == "sublimetext" ]]; then
        wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
        sudo apt-get install apt-transport-https
        echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
        sudo apt-get update
        sudo apt-get install sublime-text -y
        
    elif [[ $app_name == "vlc" ]]; then
        sudo apt install vlc
        
    elif [[ $app_name == "timeshift" ]]; then
        sudo apt install timeshift
        
    elif [[ $app_name == 'etcher' ]]; then
        echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
        sudo apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv-keys 379CE192D401AB61
        sudo apt-get update
        sudo apt-get install balena-etcher-electron
    fi
    
}

download_software() {
    cd ~/Downloads
    
    local app_name=$1

    if [[ $app_name == 'vscode' ]]; then
        wget -O code.deb https://go.microsoft.com/fwlink/?LinkID=760868 -q --show-progress
        
    elif [[ $app_name == 'google-chrome' ]]; then
        wget -O google-chorme.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -q --show-progress
        
    elif [[ $app_name == 'atom' ]]; then
        wget -O atom.deb https://atom.io/download/deb -q --show-progress
        
    elif [[ $app_name == 'gitkraken' ]]; then
        wget -O gitkraken.deb https://release.gitkraken.com/linux/gitkraken-amd64.deb -q --show-progress
        
    elif [[ $app_name == 'mailspring' ]]; then
        wget -O mailspring.deb https://updates.getmailspring.com/download?platform=linuxDeb -q --show-progress
        
    elif [[ $app_name == "simplenote" ]]; then
        curl -s https://api.github.com/repos/Automattic/simplenote-electron/releases/latest \
        | grep "browser_download_url.*amd64.deb" \
        | cut -d : -f 2,3 \
        | tr -d \" \
        | wget -qi - --show-progress
    fi
    
}

install_addons() {
    # Vundle
    if [[ ! -f "~/.vimrc" ]]; then
        ln -s ~/Documents/Github/config_files/.vimrc ~/.vimrc
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi
}


# Run functions


echo -e "\nInstalling dependencies\n"
sudo apt install curl wget gdebi vim git neofetch

echo -e "\nSome software will be downloaded as .deb files in the direcotry you specified and installed later"

pause "\nPress [Enter] to continue"

read -p "Do you wish to install all the software available? [y/n] : " install_ans

case $install_ans in
    [Yy]*)
        
        echo "Installing software..."
        for app in ${INSTALL_SOFTWARE[@]}; do
            echo "\n Installing $app \n\n"
            install_software $app
            
        done
        
        echo "Downlading Software in $LOCATION"
        for app in ${DOWNLOAD_SOFTWARE[@]}; do
            download_software $app
        done
        
        echo ""
        pause 'Press [Enter] key to continue installing the downloading files.'
        echo ""
        
        for deb_file in $LOCATION/*deb; do
            if test -f $deb_file; then
                get_package_name $deb_file
                check_if_pkg_installed $pkg_name
                if $pkg_not_installed; then
                    sudo gdebi $deb_file -n
                fi
            else
                echo 'No deb file found in this directory'
            fi
        done
        
        clear
        echo "Installing Vundle"
        install_addons
        
    ;;
    
    [Nn]*)
        
        echo "Install it manually then"
    ;;
esac
