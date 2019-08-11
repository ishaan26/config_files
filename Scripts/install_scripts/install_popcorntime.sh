## install popcorn time
#Dependencies
sudo apt update && sudo apt install libcanberra-gtk-module libgconf-2-4

# Download pkg
cd ~/Downloads
wget -i https://mirror03.popcorntime.sh/repo/build/Popcorn-Time-0.3.10-Linux-64.tar.xz

sudo mkdir /opt/popcorntime

sudo tar Jxf Popcorn-Time-* -C /opt/popcorntime

sudo ln -sf /opt/popcorntime/Popcorn-Time /usr/bin/Popcorn-Time

sudo touch /usr/share/applications/popcorntime.desktop

sudo bash

read -r -d '' DESKTOP_ENTRY << EOF
[Desktop Entry]
Version = 1.0
Type = Application
Terminal = false
Name = Popcorn Time
Exec = /usr/bin/Popcorn-Time
Icon = /opt/popcorntime/popcorn.png
Categories = Application;
EOF

echo "$DESKTOP_ENTRY" >> /usr/share/applications/popcorntime.desktop

exit

#Set Icon
sudo wget -O /opt/popcorntime/popcorn.png https://upload.wikimedia.org/wikipedia/commons/d/df/Pctlogo.png
