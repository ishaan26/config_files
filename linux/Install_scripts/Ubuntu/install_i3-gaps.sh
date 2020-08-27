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



echo -e "\nInstalling dependencies\n"

sudo apt install curl cmake libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
    libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
    libstartup-notification0-dev xbacklight libxcb-randr0-dev \
    libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
    libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
    autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev gcc make dh-autoreconf libxcb-keysyms1-dev \
    libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev \
    libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev \
    libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev -y

sudo apt install libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev build-essential \
    git cmake cmake-data pkg-config python3-sphinx bison flex\
    libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev \
    python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev \
    libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev \
    libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev \
    libnl-genl-3-dev fonts-materialdesignicons-webfont kitty indent libanyevent-i3-perl \
    libx11-dev libxcomposite-dev libxdamage-dev libxfixes-dev libxrandr-dev \
    libxinerama-dev libconfig-dev libdbus-1-dev mesa-common-dev asciidoc lxappearance \
    gtk-chtheme qt5ct freeglut3-dev feh jq libxcb-render0-dev libffi-dev python-dev python-cffi -y

sudo apt install viewnior scrot mpc acpi dunst filelight texinfo policykit-1-gnome\
    gnome-disk-utility gnome-system-monitor aptitude texinfo dolphin konsole -y

# Rofi dependencies
sudo aptitude install libjpeg-dev librsvg2-dev libglib2.0-dev -y


function install_i3() {
    # clone repo 
    cd ~/Documents

    if ! type i3 >>/dev/null; then

        echo -e "\nInstalling i3-rounded-corners\n"

        rm -rf i3

        git clone https://www.github.com/Airblader/i3 i3-gaps
        cd i3

        # compile & install
        autoreconf --force --install
        rm -rf build/
        mkdir -p build && cd build/

        # Disabling sanitizers is important for release versions!
        # The prefix and sysconfdir are, obviously, dependent on the distribution.
        ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
        make
        sudo make install
    else
        echo -e "\ni3 is already installed"
    fi
}

function download_polybar() {
    cd ~/Documents

    echo -e "\nDownlading latest release of polybar in $HOME/Documentes\n"

    polybar_release_link=$(curl -s https://api.github.com/repos/polybar/polybar/releases/latest | jq -r ".assets[].browser_download_url")
    wget $polybar_release_link -q --show-progress

    rm -rf polybar
    tar -xvf polybar*.tar
    rm -rf polybar*.tar
}

function install_polybar() {
    if ! type polybar >/dev/null; then
        cd polybar

        mkdir build
        cd build

        cmake ..
        make -j$(nproc)

        # Optional. This will install the polybar executable in /usr/local/bin
        sudo make install
    else
        echo -e "\nPolybar is already installed. Please uninstall it before instaling a different version."
    fi
}

function install_polybar_plugins() {

    sudo apt install python-dbus
    sudo apt install yad xdotool
    sudo apt install python3-pip

}

function install_compton() {
    if ! type compton >/dev/null; then
        cd ~/Documents
        git clone https://github.com/tryone144/compton.git
        cd compton
        make
        make docs 

        sudo make install
    fi
}

function install_rofi() {
    cd /tmp

    # First install the latest version of check
    git clone https://github.com/libcheck/check.git
    cd /tmp/check
    autoreconf --install
    ./configure
    make
    make check
    sudo make install
    sudo ldconfig

    cd /tmp
    # Install latest version of rofi
    git clone --recursive https://github.com/DaveDavenport/rofi
    cd /tmp/rofi/
    autoreconf -i
    mkdir build && cd build
    ../configure
    make
    sudo make install

}

function setup_config_files() {
    cd ~/.config
    echo -e "\nDirectory changed to $(pwd)\n"

    for file in ~/Documents/Github/config_files/linux/.config/*; do
        filename="$(basename $file)"
        ln -s ~/Documents/Github/config_files/linux/.config/$filename $filename
        echo "Linked $filename config files"
    done

    # permissions for scripts
    chmod 755 ~/.config/rofi/scripts/*
    chmod 755 ~/.config/polybar/scripts/*

}

function install_addons() {
    pip3 install flashfocus
}


# Let it RUN!

cd ~/Documents
echo -e "\nDirectory set to $(pwd)\n"

clear
pause "Press [Enter] to install dependencies"
install_dependencies

clear
pause "Press [Enter] to install i3-gapps-rounded"
install_i3

clear
pause "Press [Enter] to install polybar"

if test -f ~/Documents/polybar/version.txt; then
    polybar_version=$(tac ~/Documents/polybar/version.txt | egrep -m 1 .)install polybar
    echo -e "\nPolybar version $polybar_version already downloaded"
    echo -e "Do you want to download it again? (Downloaded file will be deleted) [y/n]\n"
    read answer
    if [[ answer == 'y' ]]; then
        download_polybar
    else
        echo -e "\nOkay skipping download"
    fi
else
    download_polybar

fi

install_polybar
install_polybar_plugins

clear
pause "Press [Enter] to install compton"
install_compton

clear
pause "Press [Enter] to install rofi"
install_rofi

clear
pause "Press [Enter] to Setup config files"
setup_config_files

clear
pause "Press [Enter] to Install final Addons"
install_addons
