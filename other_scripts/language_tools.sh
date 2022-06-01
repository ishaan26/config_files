#!/bin/bash

# Rust toolchain
if hash rustup &>/dev/null; then
    echo "rust is already installed"
else
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.nvm/nvm.sh
nvm install node

# language packages and utilities
# Ubuntu
if hash 2>/dev/null apt; then
    sudo snap install shfmt
    sudo apt install zsh gcc cmake clang default-jre default-jdk astyle build-essentials pkg-config libssl-dev
elif hash 2>/dev/null pacman; then
    arch_packages="shfmt zsh gcc cmake clang jdk-openjdk jre-openjdk astyle python"
    sudo pacman -S $arch_packages --needed --noconfirm
elif [ "Darwin" == "$(uname -s)" ]; then
    brew install shfmt astyle
fi

# Other language tools
echo "Installing python formatter"
pip install yapf

echo "Installing HTML, CSS, JavaScript formatter"
if ! npm list -g js-beautify >/dev/null 2>&1; then
    npm install -g js-beautify
else
    echo "Already Installed"
fi

echo "Installing TypeScript formatter"
if ! npm list -g typescript-formatter >/dev/null 2>&1; then
    npm install -g typescript-formatter
else
    echo "Already Installed"
fi
