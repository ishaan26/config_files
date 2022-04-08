#!/bin/bash

clear

SCRIPT_DIR="$(dirname "$0")"

cd "${SCRIPT_DIR}"
source ../common.sh

check_os

if hash 2>/dev/null apt; then
    echo ""
else
    echo "Scripts is not for $OS"
    exit
fi
# Install Dependencies
sudo apt install zsh zsh-doc curl wget neofetch python3 git font-manager tmux neovim vim fzf autojump

# Install Oh my zsh
cd $HOME
sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch || {
    echo "Could not install Oh My Zsh" >/dev/stderr
    exit 1
}

# Install custom Plugins
cd $HOME
echo -e "\nInstalling zsh syntax highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

clear
echo -e "\nInstalling zsh autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

clear
echo -e "\nInstalling Powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# Install tmux
ln -sf $HOME/Documents/Github/config_files/.tmux.conf $HOME/.tmux.conf

# Link config files
cd $HOME
rm .zshrc
ln -s $HOME/Documents/Github/config_files/linux/.zshrc $HOME/.zshrc
ln -s $HOME/Documents/Github/config_files/linux/.arch_aliases $HOME/.aliases
ln -s $HOME/Documents/Github/config_files/.p10k.zsh $HOME/.p10k.zsh
ln -s $HOME/Documents/Github/config_files/.tmux.conf $HOME/.tmux.conf

# Vim setup
ln -sf $HOME/Documents/Github/config_files/.vimrc $HOME/.vimrc
ln -sf $HOME/Documents/Github/config_files/linux/.config/nvim $HOME/.config/nvim

echo "\nAll Done\n"
pause "Press [Enter] to contiunue to main menu"
