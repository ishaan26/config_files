if status is-interactive

	####################################
	# Greetings
	####################################
	function fish_greeting
		figlet -f $CF/patched\ fonts/figlet-fonts/ANSI\ Shadow "Greetings"  | lolcat -tp 1 && fortune | lolcat -t
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
	# Utility functions for zoxide.

	# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
	function __zoxide_pwd
		builtin pwd -L
	end

	# A copy of fish's internal cd function. This makes it possible to use
	# `alias cd=z` without causing an infinite loop.
	if ! builtin functions -q __zoxide_cd_internal
		if builtin functions -q cd
			builtin functions -c cd __zoxide_cd_internal
		else
			alias __zoxide_cd_internal='builtin cd'
		end
	end

	# cd + custom logic based on the value of _ZO_ECHO.
	function __zoxide_cd
		__zoxide_cd_internal $argv
	end

	## Hook conif

	# Initialize hook to add new entries to the database.
	function __zoxide_hook --on-variable PWD
		test -z "$fish_private_mode"
		and command zoxide add -- (__zoxide_pwd)
	end

	set __zoxide_z_prefix 'z!'

	# Jump to a directory using only keywords.
	function __zoxide_z
		set -l argc (count $argv)
		set -l completion_regex '^'(string escape --style=regex $__zoxide_z_prefix)'(.*)$'

		if test $argc -eq 0
			__zoxide_cd $HOME
		else if test "$argv" = -
			__zoxide_cd -
		else if test $argc -eq 1 -a -d $argv[1]
			__zoxide_cd $argv[1]
		else if set -l result (string match --groups-only --regex $completion_regex $argv[-1])
			__zoxide_cd $result
		else
			set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
			and __zoxide_cd $result
		end
	end

	# Completions for `z`.
	function __zoxide_z_complete
		set -l tokens (commandline --current-process --tokenize)
		set -l curr_tokens (commandline --cut-at-cursor --current-process --tokenize)

		if test (count $tokens) -le 2 -a (count $curr_tokens) -eq 1
			# If there are < 2 arguments, use `cd` completions.
			__fish_complete_directories "$tokens[2]" ''
		else if test (count $tokens) -eq (count $curr_tokens)
			# If the last argument is empty, use interactive selection.
			set -l query $tokens[2..-1]
			set -l result (zoxide query --exclude (__zoxide_pwd) -i -- $query)
			and echo $__zoxide_z_prefix$result
			commandline --function repaint
		end
	end

	# Jump to a directory using interactive search.
	function __zoxide_zi
		set -l result (command zoxide query -i -- $argv)
		and __zoxide_cd $result
	end

	# Commands for zoxide. Disable these using --no-cmd.

	abbr --erase z &>/dev/null
	complete --command z --erase
	function z
		__zoxide_z $argv
	end
	complete --command z --no-files --arguments '(__zoxide_z_complete)'

	abbr --erase zi &>/dev/null
	complete --command zi --erase
	function zi
		__zoxide_zi $argv
	end


	zoxide init fish | source


	####################################
	# Environment variables
	####################################

	## For Tauri
	set -Ux JAVA_HOME /Applications/Android Studio.app/Contents/jbr/Contents/Home
	set -Ux ANDROID_HOME $HOME/Library/Android/sdk
	set -Ux NDK_HOME $ANDROID_HOME/ndk/26.1.10909125

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

	# Cargo Environment Variables
	export CARGO_TARGET_DIR="$HOME/.cargo/target_dump/"


	## For Bat
	# To use batpipe, eval the output of this command in your shell init script.
	set -x LESSOPEN "|/usr/local/bin/batpipe %s";
	set -e LESSCLOSE;

	# The following will enable colors when using batpipe with less:
	set -x LESS "$LESS -R";
	set -x BATPIPE "color";

	####################################
	# Aliases
	####################################

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

	if command -v lsd >>/dev/null 2>&1
		alias l="~/.cargo/bin/lsd -lah"
		alias ll="~/.cargo/bin/lsd -lh"
		alias ls="~/.cargo/bin/lsd"
		alias tree="~/.cargo/bin/lsd --tree"
	end

	if command -v nvim >>/dev/null 2>&1
		alias vim="nvim"
		alias vimf='nvim "$(find . | fzf --height 60% --layout=reverse-list --preview \'bat --color=always --style=changes {}\' --preview-window=right:60%:wrap --color=\'fg:#e5c07b,fg+:#282c34,bg:,bg+:#61afef\' --border)"'

	end

	if command -v tmux >>/dev/null 2>&1
		alias tk="tmux kill-session -a"
		alias ta="tmux attach-session -t Hack"
	end

	if command -v zoxide >>/dev/null 2>&1
		alias cd="z"
	end

	if command -v bat >>/dev/null 2>&1
		alias cat="~/.cargo/bin/bat -p"
	end

	if command -v batman >>/dev/null 2>&1
		alias man="batman"
	end

end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH


# iterm
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

fzf_configure_bindings --directory=\cf --variables=\e\cv

# Atuin
set -gx ATUIN_NOBIND "true"
atuin init fish | source

# bind to ctrl-r in normal and insert mode, add any other bindings you want here too
bind \cr _atuin_search
bind -M insert \cr _atuin_search
