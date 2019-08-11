#!/usr/bin/env bash

## install compton
# sudo apt install compton

## Dependencies (found using apt-files search)
sudo apt install -y libx11-6 libxcomposite-dev libxdamage-dev libxfixes-dev libxext-dev libxrender-dev libxrandr-dev libxinerama-dev libconfig9 libglib2.0-dev x11proto-dev libpcre3-dev libconfig9 libdrm2 libdrm-dev asciidoc libconfig-dev libdbus-1-dev mesa-common-dev libgl1-mesa-dev

cd /tmp
# rm -rf compton-kawase-blur
# git clone https://github.com/GabrielTenma/compton-kawase-blur.git
cd compton-kawase-blur

sudo bash
make
make docs
make install
exit
