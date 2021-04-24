#!/bin/bash

if [[ $(lsb_release -si >/dev/null 2>&1) == "Ubuntu" ]]; then
    # shell
    sudo snap install shfmt
    # C, C++, C#, Java
    sudo apt install astyle
elif [[ $(sw_vers -productName >/dev/null 2>&1) == "Mac OS X" ]]; then
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


