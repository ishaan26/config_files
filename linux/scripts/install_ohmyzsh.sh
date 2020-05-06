#!/usr/bin/env bash

clear

cd ~

ARG=$1

DEPENDENCIES=('zsh' 'zsh-doc' 'curl' 'wget' 'neofetch' 'python3' 'git' 'font-manager')


# Setup Scripts

function check_root {
    if ! sudo -nv 2>/dev/null; then
        echo 'Root privlages are required'
        sudo -v
    fi
}

function check_if_pkg_installed {
    local pkg=$1

    if type $pkg > /dev/null 2>&1; then
        echo "$pkg is already installed"
        pkg_not_installed=false
    else
        pkg_not_installed=true
    fi
}

function pause {
   read -p "$*"
}

function tell_location {
    echo -e "Location changed to $(pwd)\n"
}


# Install Scripts

function clone_config_files {
    cd ~/Documents/Github
    git clone https://github.com/ishaan26/config_files.git
}


function install_dependencies {
    for dep in ${DEPENDENCIES[@]}; do
        check_if_pkg_installed $dep
        if $pkg_not_installed; then
            sudo apt install $dep -y
        fi
    done
}


# Install and Setup Scripts
function install_oh_my_zsh {
    cd ~
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function install_addons {
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

function soft_link_zshrc {
    rm .zshrc .ubuntu_aliases
    ln -s ~/Documents/Github/config_files/linux/.zshrc .zshrc
    ln -s ~/Documents/Github/config_files/linux/.ubuntu_aliases .ubuntu_aliases
}


if [[ "$OSTYPE" != "linux-gnu" ]]; then
    echo -e "Scripts is only for ubuntu"
    exit
elif [[ $(awk -F '=' '/PRETTY_NAME/ { print $2 }' /etc/os-release) != '"Ubuntu 19.10"' ]]; then
    echo -e "\n Script is only tested on Ubuntu 19.10."
    pause "Press [Enter] still proceed"
fi


if [[ $ARG == '-h' ]]; then
    echo -e "\n--install --> install oh-my-zsh"
    echo -e "--setup --> install addons and config files\n"
elif [[ $ARG == '--install' ]]; then
    check_root
    install_dependencies
    clone_config_files
    install_oh_my_zsh
elif [[ $ARG == '--setup' ]]; then
    check_root
    install_addons
    soft_link_zshrc
    pause 'Restart the terminal window to see changes. Press [Enter] to continue'
    exit
else
    echo -e '\n-h for help'
fi
