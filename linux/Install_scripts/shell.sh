#!/bin/bash

clear

SCRIPT_DIR="$(dirname "$0")"

cd "${SCRIPT_DIR}"
source ./common.sh

# Install dependencies
sudo pacman -S zsh --needed

# Install Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch

# Install custom Plugins
echo -e "\nInstalling zsh syntax highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo -e "\nInstalling zsh autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo -e "\nInstalling Powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# Install tmux
ln -sf $HOME/Documents/Github/config_files/.tmux.conf $HOME/.tmux.conf

# Link config files
rm .zshrc
ln -s $HOME/Documents/Github/config_files/linux/.zshrc $HOME/.zshrc
ln -s $HOME/Documents/Github/config_files/linux/.aliases.sh
ln -s $HOME/Documents/Github/config_files/.p10k.zsh $HOME/.p10k.zsh
ln -s $HOME/Documents/Github/config_files/.tmux.conf $HOME/.tmux.conf

# vim and neovim setup
ln -sf $HOME/Documents/Github/config_files/.vimrc $HOME/.vimrc
ln -sf $HOME/Documents/Github/config_files/linux/.config/nvim $HOME/.config/nvim

echo -e "\nAll Done\n"
pause "Press [Enter] to contiunue to main menu"
