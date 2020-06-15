# Linux, Mac, Termux and WSL Configuration files

These are all my config files from different systems I use and also some patched nerdfonts. I try to keep this repo updated and add more stuff regularly.

***I am not resposible for any harm caused to you system by using these files or runnig any commands mentioned below.***

## Includes

- i3-gapps files in the linux folder which also includes:
  - polybar config
  - kitty config
  - compton(tryone) config
  - rofi config
- .zshrc files for all four systems
  - zshrc is from oh-my-zsh and includes the following plugins:
    - powerlevel9k
    - zsh-systax-highlighting
- aliases files for mac, linux and termux (for WSL the alias file of linux can be used)
- termux shell config files
- Windows Terminal profile settings
- some patched nerdfornts

## Dependencies

- oh-my-zsh
  - powerlevel9k
  - zsh-systax-highlighting
- Gitkraken
- ocrmypdf (I am a law student so have to read alot of scanned documents)
- rEFInd
- some patched nerdfornts

### Dependency Install commands

```shell
# Dependencies for building dependencies

sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
libstartup-notification0-dev libxcb-randr0-dev \
libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev -y

sudo apt install gcc make dh-autoreconf libxcb-keysyms1-dev \
libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev \
libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev\
libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev \
libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev -y

sudo apt install build-essential git cmake cmake-data pkg-config python3-sphinx \
libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev \
python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev -y

sudo apt install libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev \
libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev \
libnl-genl-3-dev fonts-materialdesignicons-webfont -y

sudo apt install libx11-dev libxcomposite-dev libxdamage-dev libxfixes-dev\
libxrandr-dev libxinerama-dev libconfig-dev libdbus-1-dev\
mesa-common-dev asciidoc lxappearance \
gtk-chtheme qt4-qtconfig freeglut3-dev feh jq zsh zsh-doc -y

# From apt

sudo apt install gitkraken ocrmypdf rofi kitty

# oh-my-zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#Addons for oh-my-zsh

# Powerlevel9k
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
# zsh-systax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# polybar

git clone https://github.com/jaagr/polybar.git
cd polybar
./build.sh

# compton tryone

git clone https://github.com/tryone144/compton.git
cd compton
make
make docs
sudo make install

# i3-gapps-rounded

git clone https://github.com/resloved/i3.git
cd i3
# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/
# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install

# Install Refind (**IF YOU DONOT KNOW WHAT IT IS, LEAVE IT ALONE**)

sudo apt-add-repository ppa:rodsmith/refind
sudo apt update
sudo apt install refind
```

## Notes

1. The Polybar config file has only been tested on Acer Predator Helios 300 G-572 and therefore correspond to its hardware only. You will need to change hardware module settings to match your hardware. (see the polybar folder for more info)
2. The linux config files have been tested on Ubuntu 19.10 and 20.04.
3. The mac files have been testede on Mac Os Catalinia 10.15.4.
4. The andorid logo in termux shell is slightly offset towards right.

### Pro tip

 Soft link the config files and aliases files to the desired location directly from the git repo so that your changes can be directly uploaded to your github if you choose to do so.

 *In any case the files will still work if you just copy them to there supposed location*.

  ```shell
  cd <location to where the file is supposed to be linked>
  ln -s <location of original files> <name of the linked file>
  ```

## Look of i3 and terminal theme

To see my i3 config, refer to this [reddit post](https://www.reddit.com/r/unixporn/comments/cwlk8i/i3gaps_a_blurry_rice/?utm_source=share&utm_medium=web2x)

- PS: This is an old post when I was using manjaro but the config files now work with Ubuntu. (I have not tested them on Manjaro)
