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
    cargo-generate \
    ytop \
    tealdeer \
    viu \
    git-delta \
    gping \
    cargo-outdated \
    cargo-tree \
    

cargo install\
    tokei --features all
