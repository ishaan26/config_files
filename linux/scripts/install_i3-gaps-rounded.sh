#!/usr/bin/env bash
clear

UBUNTU_VERSION="20.04"

function check_system() {
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

function check_root() {
    if ! sudo -nv 2>/dev/null; then
        echo 'Root privlages are required'
        sudo -v
    fi
}

function pause() {
    read -p "$*"
    clear
}

function install_dependencies() {
    echo -e "\nInstalling dependencies\n"

    sudo apt install curl cmake libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
        libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
        libstartup-notification0-dev libxcb-randr0-dev \
        libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
        libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
        autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev gcc make dh-autoreconf libxcb-keysyms1-dev \
        libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev \
        libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev \
        libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev \
        libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev\ 
        lm-sensors build-essential git cmake cmake-data pkg-config python3-sphinx \
        libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev \
        python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev \
        libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev \
        libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev \
        libnl-genl-3-dev fonts-materialdesignicons-webfont kitty rofi indent libanyevent-i3-perl \
        libx11-dev libxcomposite-dev libxdamage-dev libxfixes-dev libxrandr-dev \
        libxinerama-dev libconfig-dev libdbus-1-dev mesa-common-dev asciidoc lxappearance \
        gtk-chtheme qt5ct freeglut3-dev feh jq libxcb-render0-dev libffi-dev python-dev python-cffi -y

}

function install_i3() {
    # clone repo
    cd ~/Documents

    if ! type i3 >/dev/null; then

        echo -e "\nInstalling i3-rounded-corners\n"

        rm -rf i3

        git clone https://github.com/resloved/i3.git
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

    echo -e "\nDownlading latest release of polybar\n"

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
    cd ~/Documents
    mkdir -p OtherGits/polybar_plugins
    cd OtherGits/ploybar_plugins

    #spotify plugin 
    git clone https://github.com/Jvanrhijn/polybar-spotify.git
    sudo apt install python-dbus
    #polybar-scripts
    git clone https://github.com/polybar/polybar-scripts.git

    #Execute permissions are not set in the git
    for i in $(find | grep "\.sh"); do 
        chmod 755 $i 
    done

    sudo apt install yad xdotool

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

function setup_config_files() {
    cd ~/.config
    echo -e "\nDirectory changed to $(pwd)\n"

    for file in ~/Documents/Github/config_files/linux/.config/*; do
        filename="$(basename $file)"
        ln -s ~/Documents/Github/config_files/linux/.config/$filename $filename
        echo "Linked $filename config files"
    done
}

function install_addons() {
    pip3 install flashfocus
}

# Let it RUN!

check_system

cd ~/Documents
echo -e "\nDirectory set to $(pwd)\n"

check_root

pause "\nPress [Enter] to install dependencies"
install_dependencies

pause "\nPress [Enter] to install i3-gapps-rounded"
install_i3

pause "\nPress [Enter] to install polybar"
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

pause "\nPress [Enter] to install compton"
install_compton

pause "\nPress [Enter] to Setup config files"
setup_config_files

install_addons
