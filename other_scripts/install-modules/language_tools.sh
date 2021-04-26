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
