#!/usr/bin/env bash
clear

SCRIPT_DIR="$(dirname "$0")"


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
    echo "\n Script is not tested on version $VER"
    pause "Press [Enter] still proceed"
fi

check_root # Checks sudo privlages of the shell from common.sh

