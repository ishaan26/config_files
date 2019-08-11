#!/usr/bin/env bash

# dependencies
sudo apt install gdebi libqt5core5a -y

## To install all the deb files in a directory using gdebi through a loop
for file in ./*.deb; do
  sudo gdebi $file
done
