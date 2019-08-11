#!/usr/bin/env bash

./repos.sh

sudo apt update && sudo apt upgrade -y

sudo apt install -y --install-suggests\
	git\
	vim\
	python3\
	libreoffice\
	kdenlive\
	krita\
	timeshift\
	vlc\
	lxappearance\
	font-manager\
	dolphin\
