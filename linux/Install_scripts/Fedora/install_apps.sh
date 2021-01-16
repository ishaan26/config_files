#!/usr/bin/env bash
clear

SCRIPT_DIR="$(dirname "$0")"
LOCATION=~/Downloads

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

clear
cd $LOCATION
tell_location
echo ""
pause "Press [Enter] to continue installing apps"

echo -e "\nUpdating system"
sudo dnf update -y
clear

echo -e "Configuring Repositorires\n"
# Rpm Fusion 
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate core -y
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
sudo dnf groupupdate sound-and-video -y
sudo dnf install -y rpmfusion-free-release-tainted
sudo dnf install -y libdvdcss
sudo dnf install -y rpmfusion-nonfree-release-tainted 
sudo dnf install -y \*-firmware
echo -e "\nConfigured rpm fusion\n"
pause "Press [Enter] to continue"


echo "Installing dnf apps"
sudo dnf install -y vlc mono-complete filelight golang qt-devel cmake gnome-tweak-tool xfce4-terminal kvantum qt5ct lxappearance Virtualbox 
echo -e "\nInstalled many apps\n"
pause "Press [Enter] to continue"


echo "Installing other apps"
sleep 1

echo "Installing Google Chrome"
sudo dnf install fedora-workstation-repositories -y
sudo dnf config-manager --set-enabled google-chrome
sudo dnf install google-chrome-stable -y
clear


echo "Installing snap"
sudo dnf install snapd -y
sudo ln -s /var/lib/snapd/snap /snap
echo -e "\nSnap will be available after reboot"
pause "Press [Enter] to continue"
clear


echo "Installing Visual Studio Code"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install -y code
clear

echo "Installing Atom"
sudo rpm --import https://packagecloud.io/AtomEditor/atom/gpgkey
sudo sh -c 'echo -e "[Atom]\nname=Atom Editor\nbaseurl=https://packagecloud.io/AtomEditor/atom/el/7/\$basearch\nenabled=1\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://packagecloud.io/AtomEditor/atom/gpgkey" > /etc/yum.repos.d/atom.repo'
sudo dnf install -y atom
clear

echo "Installing MailSpring"
cd $LOCATION
wget -O mailspring.rpm https://updates.getmailspring.com/download?platform=linuxRpm -q --show-progress
sudo dnf install ./mailspring.rpm -y
echo ""
pause "Press [Enter] to continue"
clear

echo "Installing and setting up vim"
sudo dnf install -y vim
if [[ ! -f "~/.vimrc" ]]; then
    cd ~
    ln -s ~/Documents/Github/config_files/.vimrc
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo -e "\nAll Done\n"
pause "Press [Enter] to continue to main menu"
