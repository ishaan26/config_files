# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


export TERM="xterm-256color"
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"


plugins=(
    git
    osx
    python
    zsh-syntax-highlighting
    rust
    rustup
    cargo
    brew
    nvm
    autojump
    zsh-autosuggestions
)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=241,bold,underline"

source $ZSH/oh-my-zsh.sh


#environment variables
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"

#Sources
source ~/.aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#vi:syntax=sh
