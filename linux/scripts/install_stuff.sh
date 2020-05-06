bash
clear

LOCATION=$1

if ! [ "$LOCATION" ]; then
    echo "Please specify a directory as the argument\n"
    exit
fi

cd $LOCATION

echo -e "Location changed to $(pwd)\n"

APPS=('vscode' 'google-chrome' 'spotify' 'papirus' 'atom' 'gitkraken' 'mailspring' 'flatpak')

DEPENDENCIES=('curl' 'wget' 'gdebi' 'vim' 'git' 'neofetch' 'vlc' 'exfat-fuse' 'exfat-utils')



# Setup Functions:
function check_root {
    if ! sudo -nv 2>/dev/null; then
        echo 'Root privlages are required'
        sudo -v
    fi
}

function pause {
   read -p "$*"
}

function get_package_name {
    local deb=$1

    pkg_name=$(dpkg-deb -I $deb | grep -Po "Package: \K[^ ]+")
}


function check_if_pkg_installed {
    local pkg=$1

    if [[ $(dpkg -l $pkg | grep -io desired) == 'Desired' ]]; then
        echo "$pkg is already installed"
        pkg_not_installed=false
    else
        pkg_not_installed=true
    fi
}


function install_dependencies {
    check_root
    
    for depend in ${DEPENDENCIES[@]}; do
        check_if_pkg_installed $depend

        if $pkg_not_installed; then
	    echo -e "\nInstalling $depend"
	    sudo apt -qq install $depend -y  
        fi
    done
}



# Downloads:
function question {
    local app_name=$1

    echo -e "\nDo you want to download and install $app_name? [y/n]:"
    read answer
}

function install_apps {
    cd ~/Downloads

    local app_name=$1

    if [[ $app_name == 'vscode' ]]; then
        wget -O code.deb https://go.microsoft.com/fwlink/?LinkID=760868 -q --show-progress
    elif [[ $app_name == 'google-chrome' ]]; then
        wget -O google-chorme.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -q --show-progress
    elif [[ $app_name == 'atom' ]]; then
        wget -O atom.deb https://atom.io/download/deb -q --show-progress
    elif [[ $app_name == 'spotify' ]]; then
        curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
        echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
        sudo apt update && sudo apt install spotify-client -y
    elif [[ $app_name == 'papirus' ]]; then
        sudo add-apt-repository ppa:papirus/papirus
        sudo apt-get update
        sudo apt-get install papirus-icon-theme
    elif [[ $app_name == 'gitkraken' ]]; then
        wget -O gitkraken.deb https://release.gitkraken.com/linux/gitkraken-amd64.deb -q --show-progress
    elif [[ $app_name == 'mailspring' ]]; then
        wget -O mailspring.deb https://updates.getmailspring.com/download?platform=linuxDeb -q --show-progress
    elif [[ $app_name == 'flatpak' ]]; then
        sudo apt install flatpak
        sudo apt install gnome-software-plugin-flatpak
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    fi
}


# Run functions

if [[ "$OSTYPE" != "linux-gnu" ]]; then
    echo -e "Scripts is only for ubuntu"
    exit
elif [[ $(awk -F '=' '/PRETTY_NAME/ { print $2 }' /etc/os-release) != '"Ubuntu 19.10"' ]]; then
    echo -e "\n Script is only tested on Ubuntu 19.10."
    pause "Press [Enter] still proceed"
fi


echo -e "\nInstalling dependencies\n"
install_dependencies

echo -e "\nSome apps would be downloaded as deb files in the direcotry you specified and installed later"

for app in ${APPS[@]}; do
    question $app
    if [[ $answer == 'y' ]]; then
        install_apps $app
    else
        echo -e 'Okay skipping'
        continue
    fi
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


zsh
