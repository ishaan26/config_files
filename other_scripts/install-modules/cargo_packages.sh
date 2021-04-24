#!/bin/bash

# dependencies
if [[ $(lsb_release -si) == "Ubuntu" ]]; then
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
    ytop \
    tealdeer \
    viu \
    git-delta \
    gping \
    cargo-outdated \
    cargo-tree \
    gitui \
    hexyl \

cargo install \
    tokei --features all \

# Install bat-extras
mkdir -p ~/Documents/OtherGits
cd ~/Documents/OtherGits
git clone https://github.com/eth-p/bat-extras.git
cd bat-extras
sudo ./build.sh --install --manuals
