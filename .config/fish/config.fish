if status is-interactive

    ####################################
    # Greetings
    ####################################
    function fish_greeting
        figlet -f $CF/patched\ fonts/figlet-fonts/ANSI\ Shadow Greetings | lolcat -tp 1 && fortune | lolcat -t
        echo -e ""
        echo -e "Uptime": (uptime) | lolcat
    end

    ####################################
    # Initialize Shell Prompt
    ####################################
    starship init fish | source

    ####################################
    # Start Tmux
    ####################################
    if status is-interactive
        and not set -q TMUX
        exec tmux
    end


    ####################################
    # Zoxide 
    ####################################

    zoxide init fish | source


    ####################################
    # Environment variables
    ####################################

    #GPG
    export GPG_TTY=$(tty)

    ## qt5ct Environment Variable
    set -u QT_QPA_PLATFORMTHEME qt5ct

    ## Set mouse scrolling with less
    set -u LESS --mouse --wheel-lines=3

    ## Github Folders
    set -u CF $HOME/Documents/Github/config_files
    set -u PJT $HOME/Documents/Github/Learning
    set -u RS $HOME/Documents/Github/zung

    ## Set Editor
    set -u VISUAL nvim
    set -u EDITOR nvim

    ## RUST
    export CARGO_TARGET_DIR="$HOME/.cargo/target_dump/"
    source "$HOME/.cargo/env.fish"

    # fnm init
    source "$HOME/.config/fish/conf.d/fnm.fish"
    eval "$(fnm env)"

    #GPG
    export GPG_TTY=$(tty)

    ## For Tauri
    switch (uname)
    case Darwin
        set -Ux JAVA_HOME /Applications/Android Studio.app/Contents/jbr/Contents/Home
        set -Ux ANDROID_HOME $HOME/Library/Android/sdk
        export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"
    case Linux
        export JAVA_HOME=$HOME/android-studio/jbr
        export ANDROID_HOME="$HOME/Android/Sdk"
        export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"
    case '*'
        # do things for other OSs
    end

    ## For Bat
    # To use batpipe, eval the output of this command in your shell init script.
    set -x LESSOPEN "|/usr/local/bin/batpipe %s"
    set -e LESSCLOSE

    # The following will enable colors when using batpipe with less:
    set -x LESS "$LESS -R"
    set -x BATPIPE color

    source "$HOME/.config/fish/api_key"

    ####################################
    # Aliases
    ####################################


    # Handy change dir shortcuts
    abbr .. 'cd ..'
    abbr ... 'cd ../..'
    abbr .3 'cd ../../..'
    abbr .4 'cd ../../../..'
    abbr .5 'cd ../../../../..'

    # Always mkdir a path (this doesn't inhibit functionality to make a single dir)
    abbr mkdir 'mkdir -p'

    # For Rust
    abbr nargo cargo +nightly


    # Shell Stuff
    function sudo
        if test "$argv" = !!
            eval command sudo $history[1]
        else
            command sudo $argv
        end
    end

    #Git stuff
    alias cf='cd "$CF" 2>/dev/null || echo "Directory not available"'
    alias pjt='cd "$PJT" 2>/dev/null || echo "Directory not available"'
    alias rs='cd "$RS" 2>/dev/null || echo "Directory not available"'
    alias githistory="git log --oneline --graph --decorate --all"
    alias gd="git diff"
    alias gah= "git stash; and git pull --rebase; and git stash pop"

    if command -v eza >>/dev/null 2>&1
        abbr ls "eza --icons"
        abbr l "eza -lah --icons"
        abbr ll "eza -Rl --icons"
        abbr tree "eza -Tl --icons"
    end

    if command -v nvim >>/dev/null 2>&1
        abbr vim nvim
        alias vimf='nvim "$(find . | fzf --height 60% --layout=reverse-list --preview \'bat --color=always --style=changes {}\' --preview-window=right:60%:wrap --color=\'fg:#e5c07b,fg+:#282c34,bg:,bg+:#61afef\' --border)"'

    end

    if command -v tmux >>/dev/null 2>&1
        abbr tk "tmux kill-session -a"
        abbr ta "tmux attach-session -t Hack"
    end

    if command -v zoxide >>/dev/null 2>&1
        abbr cd "z"
    end

    if command -v bat >>/dev/null 2>&1
        abbr cat "bat -p"
    end

    if command -v batman >>/dev/null 2>&1
        alias man="batman"
    end

end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH


# iTerm
test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish

# Atuin
set -gx ATUIN_NOBIND true
atuin init fish | source

# bind to ctrl-r in normal and insert mode, add any other bindings you want here too
bind \cr _atuin_search
bind -M insert \cr _atuin_search

# pnpm
set -gx PNPM_HOME "/Users/ishaangoel/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
