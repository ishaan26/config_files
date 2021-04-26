#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"

check_os() {
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
}

pause() {
    read -p "$*"
    clear
}

check_root() {
    if ! sudo -nv 2>/dev/null; then
        echo 'Root privlages are required'
        sudo -v
    fi
}

tell_location() {
    echo -e "Location changed to $(pwd)\n"
}

install_fonts_common() {
    FONTS="$(realpath $SCRIPT_DIR/../../patched\ fonts/fonts/)"

    sudo mkdir /usr/share/fonts/

    cd "$FONTS/"
    for font in ./*; do
        sudo cp "$font" /usr/share/fonts/
        echo "installed $font"
    done

    cd ~

    echo -e "\nBuilding font cache..."
    sudo fc-cache

    echo -e "\nAll Done\n"
    pause "Press [Enter] to continue to main menu"

}
