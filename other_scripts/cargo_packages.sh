#!/bin/bash

# dependencies
if [[ $(lsb_release -si > /dev/null 2>&1) == "Ubuntu" ]]; then
    sudo apt install libssl-dev build-essential -y
fi

cargo install\
    lsd \
    onefetch \
    bat \
    procs \
    ripgrep \
    mdbook \
    du-dust \
    fd-find \
    hyperfine \
    cargo-cache \
    cargo-update \
    cargo-watch \
    tealdeer \
    viu \
    git-delta \
    gping \
    cargo-outdated \
    cargo-tree \
    hexyl \
    bottom \

cargo install \
    tokei --features all \

# Install bat-extras
mkdir -p ~/Documents/Github/OtherGits/
cd ~/Documents/Github/OtherGits/
git clone https://github.com/eth-p/bat-extras.git
cd bat-extras
sudo ./build.sh --install --manuals
