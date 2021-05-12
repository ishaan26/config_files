#!/bin/bash

# Rust toolchain
if ! command -v rustup &>/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# Node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

if [[ $(lsb_release -si 2>/dev/null) == "Ubuntu" ]]; then
    # shell
    sudo snap install shfmt
    sudo apt install zsh
    sudo apt install gcc cmake clang
    sudo apt install default-jre
    sudo apt install default-jdk
    sudo apt install astyle
elif [[ $(lsb_release -si 2>/dev/null) == "Arch" ]]; then
    sudo pacman -S shfmt --needed --noconfirm
    sudo pacman -S zsh  --needed --noconfirm
    sudo pacman -S gcc cmake clang --needed --noconfirm
    sudo pacman -S jdk-openjdk jre-openjdk --needed --noconfirm
    sudo pacman -S astyle --needed --noconfirm
elif [[ $(sw_vers -productName 2>/dev/null) == "Mac OS X" ]]; then
    brew install shfmt
    brew install astyle
fi

# Python
if [[ $(lsb_release -si 2>/dev/null) == "Arch" ]]; then
    sudo pacman -S python --needed --noconfirm
fi

pip install yapf

# JavaScript, CSS, HTML
if ! npm list -g js-beautify >/dev/null 2>&1; then
    npm install -g js-beautify
fi

# typescript
if ! npm list -g typescript-formatter >/dev/null 2>&1; then
    npm install -g typescript-formatter
fi

# Markdown
if ! npm list -g remark-cli >/dev/null 2>&1; then
    npm install -g remark-cli
fi

# English
if ! npm list -g write-good >/dev/null 2>&1; then
    npm install -g write-good
fi
