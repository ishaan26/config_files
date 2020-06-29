#!/usr/bin/env bash

clear

UBUNTU_VERSION="20.04"

function check_system {
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
}

function check_root {
    if ! sudo -nv 2>/dev/null; then
        echo 'Root privlages are required'
        sudo -v
    fi
}

function pause {
   read -p "$*"
   clear
}

function tell_location {
    echo -e "Location changed to $(pwd)\n"
}


# Install Scripts

function install_dependencies {
    sudo apt install zsh zsh-doc curl wget neofetch python3 git font-manager
}

# Install and Setup Scripts
function install_oh_my_zsh {
    cd ~
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function install_addons {
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
}

function soft_link_zshrc {
    cd ~
    rm .zshrc .ubuntu_aliases
    ln -s ~/Documents/Github/config_files/linux/.zshrc
    ln -s ~/Documents/Github/config_files/linux/.ubuntu_aliases
    ln -s ~/Documents/Github/config_files/.vimrc
    ln -s ~/Documents/Github/config_files/.p10k.zsh
}


check_system

cd ~

if [[ $1 == '-h' ]]; then
    echo -e "\n--install --> install oh-my-zsh"
    echo -e "--setup --> install addons and config files\n"
elif [[ $1 == '--install' ]]; then
    check_root
    install_dependencies
    clone_config_files
    install_oh_my_zsh
elif [[ $1 == '--setup' ]]; then
    check_root
    install_addons
    soft_link_zshrc
    echo -e "\nPlease Reboot"
    
else
    echo -e "\n-h for help"
fi
