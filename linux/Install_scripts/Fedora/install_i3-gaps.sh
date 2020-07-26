#!/usr/bin/env bash
clear

SCRIPT_DIR="$(dirname "$0")"
GIT_CLONE_DIR="/home/$(whoami)/Documents/Github/OtherGits"

cd "$SCRIPT_DIR"
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
    echo -e "\nScript is not tested on version $VER"
    pause "Press [Enter] still proceed"
fi

check_root # Checks sudo privlages of the shell from common.sh
clear

mkdir -p "$GIT_CLONE_DIR"
cd "$GIT_CLONE_DIR"
tell_location

pause "Press [Enter] to continue installing dependencies"

echo -e "\nInstalling Dependencies..."
sudo dnf install -y yad xdotool bison polkit-gnome.x86_64 xbacklight flex libxcb-devel check-devel.x86_64 libjpeg-turbo-devel.x86_64 librsvg2-devel.x86_64 xcb-util-keysyms-devel xcb-util-devel xcb-util-wm-devel xcb-util-xrm-devel yajl-devel libXrandr-devel startup-notification-devel libev-devel xcb-util-cursor-devel libXinerama-devel libxkbcommon-devel libxkbcommon-x11-devel pcre-devel pango-devel git gcc automake i3status i3lock feh libXcomposite-devel libXdamage-devel libXrandr-devel libXinerama-devel libconfig-devel mesa-libGL-devel dbus-devel asciidoc check
sudo pip install flashfocus
pause "Press [Enter] to install i3-gaps"
clear


echo -e "\nInstalling i3-gaps"
git clone https://www.github.com/Airblader/i3.git i3-gaps
cd i3-gaps
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install
cd "$GIT_CLONE_DIR"
echo -e "\ni3-gaps installed"
pause "Press [Enter] to install compton-tryone"
clear


echo -e "Installing compton-tryone"
git clone https://github.com/tryone144/compton
cd compton
make
make docs
sudo make install
cd "$GIT_CLONE_DIR"
echo -e "\ncompton-tryone installed"
pause "Press [Enter] to install rofi"

echo -e "Installing rofi"
git clone --recursive https://github.com/DaveDavenport/rofi
cd rofi
autoreconf -i
mkdir build && cd build
../configure
make
sudo make install
cd "$GIT_CLONE_DIR"
echo -e "\nRofi installed"
pause "Press [Enter] to setup config files"


cd ~/.config
tell_location

for file in ~/Documents/Github/config_files/linux/.config/*; do
    filename="$(basename "$file")"
    ln -s ~/Documents/Github/config_files/linux/.config/"$filename" .
    echo "Linked $filename config files"
done

# permissions for scripts
chmod 755 ~/.config/rofi/scripts/*
chmod 755 ~/.config/polybar/scripts/*

echo -e "\nPlease reboot"

pause "Press [Enter] to contiunue to main menu"
