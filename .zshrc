cd $HOME

###############################
# TMUX
###############################
if command -v tmux >/dev/null 2>&1; then
    # if not inside a tmux session, and if no session is started, start a new session
    [ -z "${TMUX}" ] && (tmux new -s "Hack") >/dev/null 2>&1
fi


###############################
# P10K ZSH CONFIGRATION
###############################
# (Must stay close to the top of the .zshrc file)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


###############################
# PATHS
###############################
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:/snap/bin
export PATH=$PATH:$HOME/Library/Python 

###############################
# Terminal Setup
###############################

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    python
    rust
    zsh-syntax-highlighting
    deno
    nvm
    zsh-autosuggestions
    fzf
	keychain
	gpg-agent
)

# zoxide
if command -v zoxide >/dev/null 2>&1; then
	eval "$(zoxide init zsh)"
fi

# Globbing
setopt extended_glob
source $ZSH/oh-my-zsh.sh

# Source aliases
source ~/.aliases.sh


###############################
# Environment variables
###############################


ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=241,bold,underline"

## Terminal Colors
export TERM="screen-256color"
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"

## Export for wsl gpg verification
if [[ -n "$IS_WSL" || -n "$WSL_DISTRO_NAME" ]]; then
    export GPG_TTY=$(tty)
fi

## qt5ct Environment Variable
export QT_QPA_PLATFORMTHEME="qt5ct"

## Set mouse scrolling with less
export LESS='--mouse --wheel-lines=3'

## Github Folders
export CF="$HOME/Documents/Github/config_files"
export PJT="$HOME/Documents/Github/Learning"
export RS="$HOME/Documents/Github/zung"

## Set Editor
export VISUAL=nvim;
export EDITOR=nvim;

# Cargo Environment Variables
export CARGO_TARGET_DIR=$HOME/.cargo/target_dump

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Deno
export DENO_INSTALL="/home/ishaan/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Go
export GOPATH=/opt/homebrew/bin/go
export PATH=$GOPATH/bin:$PATH

# fzf
export FZF_DEFAULT_OPTS='-m --height 50% --border --inline-info'

if type fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_ALT_C_COMMAND='fd --type d --type l --hidden --follow --exclude .git'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

###############################
# P10K ZSH THEME
###############################

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /Users/ishaangoel/.config/broot/launcher/bash/br


zstyle :omz:plugins:keychain agents ssh,gpg
zstyle :omz:plugins:keychain identities id_rsa 0E6951900DED125D

