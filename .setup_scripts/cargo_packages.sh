#!/bin/bash

export STD='\033[0;0;39m'
export NONE='\033[00m'
export RED='\033[01;31m'
export GREEN='\033[01;32m'
export YELLOW='\033[01;33m'
export PURPLE='\033[01;35m'
export CYAN='\033[01;36m'
export WHITE='\033[01;37m'
export BOLD='\033[1m'
export UNDERLINE='\033[4m'

pause() {
    read -rp "$*"
}

install_cargo_packages() {

    echo -e "\n=> ${BOLD}${GREEN}Installing cargo packages${NONE} \n"

    if ! hash rustup &>/dev/null; then
        printf "Please install language tools first \n"
        exit
    fi

    cargo install --locked lsd \
        onefetch \
        bat \
        procs \
        ripgrep \
        mdbook \
        du-dust \
        fd-find \
        hyperfine \
        tealdeer \
        viu \
        git-delta \
        gping \
        hexyl \
        bottom \
        zoxide \
        cargo-outdated \
        cargo-cache \
        cargo-update \
        cargo-watch \
        cargo-tree \
        cargo-audit \
        cargo-nextest \
        gptcommit \
        topgrade \
        autin \
        yazi

    cargo install \
        tokei --features all

    # Install bat-extras
    mkdir -p "$HOME"/Documents/Github/OtherGits/
    cd "$HOME"/Documents/Github/OtherGits/ || echo "Failed to create OtherGits directory" && exit
    git clone https://github.com/eth-p/bat-extras.git
    cd bat-extras || echo "failed to get bat extras" && exit
    sudo ./build.sh --install --manuals

    printf "\n\nSetup atuin from https://github.com/atuinsh/atuin"

    pause "Press [Enter] to contiunue to main menu"
}
