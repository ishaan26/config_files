# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# PATHS
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:/snap/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


####################################################
#########                                  #########
#########          POWERLEVEL10K           #########
#########                                  #########
####################################################

ZSH_THEME="powerlevel10k/powerlevel10k"


plugins=(
  git
  python
  zsh-syntax-highlighting
  )

  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=051,bold,underline"


# Globbing
setopt extended_glob


source $ZSH/oh-my-zsh.sh

#environment variables
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"
export QT_QPA_PLATFORMTHEME="qt5ct"

#Sources
source ~/.aliases

# Go Path
export GOPATH="/home/ishaan/go"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/ishaan/.sdkman"
[[ -s "/home/ishaan/.sdkman/bin/sdkman-init.sh" ]] && source "/home/ishaan/.sdkman/bin/sdkman-init.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="/home/ishaan/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
