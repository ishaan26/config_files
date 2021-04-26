#!/bin/bash

# Rust toolchain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

if [[ $(lsb_release -si 2>/dev/null) == "Ubuntu" ]]; then
    # shell
    sudo snap install shfmt
    sudo apt install zsh
    # C, C++, C#, Java
    sudo apt install gcc cmake clang
    sudo apt install default-jre
    sudo apt install default-jdk
    sudo apt install astyle
elif [[ $(sw_vers -productName 2>/dev/null) == "Mac OS X" ]]; then
    # shell,
    brew install shfmt
    # C, C++, C#, Java
    brew install astyle
fi

# Python
pip install yapf

# JavaScript, CSS, HTML
npm install -g js-beautify

# typescript
npm install -g typescript-formatter
