#!/bin/bash

clear
SCRIPT_DIR="$(dirname "$0")"
cd "${SCRIPT_DIR}"
source ./common.sh

echo -e "\n=> ${BOLD}${GREEN}Installing fonts${NONE} \n"

FONTS="$(realpath "$SCRIPT_DIR"/../../patched\ fonts/fonts/)"

sudo mkdir -p /usr/share/fonts/

cd "$FONTS/" || echo "Unable to install fonts" && exit
for font in ./*; do
	sudo cp "$font" /usr/share/fonts/
	echo "installed $font"
done
echo -e "\nBuilding font cache..."
sudo fc-cache

echo -e "\nAll Done\n"
pause "Press [Enter] to continue to main menu"
