#!/usr/bin/env bash

clear

LOCATION=$1

UBUNTU_VERSION="20.04"

if ! [ "$LOCATION" ]; then
    echo "Please specify a directory as the argument\n"
    exit
fi

cd $LOCATION

echo -e "Location changed to $(pwd)\n"


# Check System as the script only works on Ubintu 20.04 based OSs
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

if [[ "$OS" != "Ubuntu" ]]; then
    echo -e "Scripts is only for Ubuntu-inux"
    exit
elif [[ "$VER" != "$UBUNTU_VERSION" ]]; then
    echo -e "\n Script is only tested on Ubuntu 20.04 LTS"
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
)

DOWNLOAD_SOFTWARE=(
    'vscode' \ 
    'google-chrome' \
    'simplenote' \
    'atom' \
    'gitkraken' \
    'mailspring' \
)


# Setup Funciotns

function pause() {
    read -p "$*"
    clear
}

function get_package_name() {
    local deb=$1

    pkg_name=$(dpkg-deb -I $deb | grep -Po "Package: \K[^ ]+")
}

function check_if_pkg_installed() {
    local pkg=$1

    if [[ $(dpkg -l $pkg | grep -io desired) == 'Desired' ]]; then
        echo "$pkg is already installed"
        pkg_not_installed=false
    else
        pkg_not_installed=true
    fi
}

# Downloads:
function question() {
    local app_name=$1
    echo -e "\nDo you want to download and install $app_name? [y/n]:"
    read answer
}

function install_dependencies() {
    sudo apt install curl wget gdebi vim git neofetch
}

function install_software() {
    cd ~/Downloads

    local app_name=$1

    if [[ $app_name == 'papirus' ]]; then
        sudo add-apt-repository ppa:papirus/papirus
        sudo apt-get update
        sudo apt-get install papirus-icon-theme

    elif [[ $app_name == 'flatpak' ]]; then
        sudo apt install flatpak
        sudo apt install gnome-software-plugin-flatpak
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    elif [[ $app_name == 'libreoffice' ]]; then
        sudo add-apt-repository ppa:libreoffice/ppa
        sudo apt install libreoffice
        sudo apt-get install libreoffice-style-papirus

    elif [[ $app_name == "sublimetext" ]]; then
        wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
        sudo apt-get install apt-transport-https
        echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
        sudo apt-get update
        sudo apt-get install sublime-text

    elif [[ $app_name == "vlc" ]]; then
        sudo apt instal vlc

    elif [[ $app_name == "timeshift" ]]; then
        sudo apt install timeshift

    fi
    
}

function download_software() {
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
install_dependencies

echo -e "\nSome software will be downloaded as .deb files in the direcotry you specified and installed later"

pause "\nPress [Enter] to continue"

read -p "Do you wish to install all the software available? [y/n] : " install_ans

case $install_ans in
[Yy]*)

    echo "Installing software..."
    for app in ${INSTALL_SOFTWARE[@]}; do
        install_software $app
    done 

    echo "Downlading Software in $LOCATION"
    for app in ${DOWNLOAD_SOFTWARE[@]}; do
        download_software $app
    done

    echo -e "\n"
    pause 'Press [Enter] key to continue installing the downloading files.'
    echo -e "\n"

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

    ;;

[Nn]*)

    echo "Install it manually then"
    ;;
esac


install_addons
