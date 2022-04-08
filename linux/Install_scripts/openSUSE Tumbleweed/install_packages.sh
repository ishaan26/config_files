#!/usr/bin/env bash

clear

SCRIPT_DIR="$(dirname "$0")"

cd "${SCRIPT_DIR}"
source ../common.sh

check_os

if hash 2>/dev/null zypper; then
    echo ""
else
    echo "Scripts is not for $OS"
    exit
fi

if ! sudo -nv 2>/dev/null; then
    echo 'Root privlages are required'
    sudo -v
fi

# Update
sudo zypper ref && sudo zypper update

# Install basic packages
sudo zypper git \
    base-devel \
    inetutils \
    net-tools \
    neovim \
    zsh \
    vlc
