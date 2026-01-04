{ pkgs, ... }:

{
  # Core shell programs
  programs.fish = {
    enable = true;

    shellInit = ''


      # Environment variables
      set -gx EDITOR nvim
      set -gx VISUAL nvim

      # Tauri/Android Development
      if test (uname) = Linux
        set -gx ANDROID_HOME "$HOME/Android/Sdk"
        if test -d "$ANDROID_HOME/ndk"
          set ndk_version (ls -1 $ANDROID_HOME/ndk 2>/dev/null | head -n 1)
          if test -n "$ndk_version"
            set -gx NDK_HOME "$ANDROID_HOME/ndk/$ndk_version"
          end
        end
      end

      # Bat/Batpipe configuration
      set -gx LESSOPEN "|${pkgs.bat-extras.batpipe}/bin/batpipe %s"
      set -e LESSCLOSE
      set -gx LESS "$LESS -R"
      set -gx BATPIPE color

      # Bun
      set -gx BUN_INSTALL "$HOME/.bun"
      set -gx PATH $BUN_INSTALL/bin $PATH

      # Cargo
      set -gx PATH $HOME/.cargo/bin $PATH
    '';

    interactiveShellInit = ''
      # Auto-start tmux for interactive shells
      if not set -q TMUX
        exec tmux
      end
    '';

    shellAbbrs = {
      # Directory navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      ".3" = "cd ../../..";
      ".4" = "cd ../../../..";
      ".5" = "cd ../../../../..";

      # Always mkdir a path
      "mkdir" = "mkdir -p";

      # Rust
      "nargo" = "cargo +nightly";

      # Eza (ls replacement)
      "ls" = "eza --icons";
      "l" = "eza -lah --icons";
      "ll" = "eza -Rl --icons";
      "tree" = "eza -Tl --icons";

      # Neovim
      "vim" = "nvim";

      # Tmux
      "tk" = "tmux kill-session -a";
      "ta" = "tmux attach-session -t Hack";

      # Zoxide
      "cd" = "z";

      # Bat
      "cat" = "bat -p";
    };

    shellAliases = {
      # Git aliases
      "githistory" = "git log --oneline --graph --decorate --all";
      "gd" = "git diff";
      "gah" = "git stash; and git pull --rebase; and git stash pop";

      # Man pages with bat
      "man" = "batman";

      # Neovim with fzf
      "vimf" = ''
        nvim "$(find . | fzf --height 60% --layout=reverse-list --preview 'bat --color=always --style=changes {}' --preview-window=right:60%:wrap --color='fg:#e5c07b,fg+:#282c34,bg:,bg+:#61afef' --border)"'';
    };

    functions = {
      # Custom fish greeting
      fish_greeting = ''
        # Check if figlet and lolcat are available
        if command -v figlet >/dev/null 2>&1; and command -v lolcat >/dev/null 2>&1
          if test -n "$CF"; and test -f "$CF/patched fonts/figlet-fonts/ANSI Shadow"
            figlet -f "$CF/patched fonts/figlet-fonts/ANSI Shadow" Greetings | lolcat -tp 1
          else
            figlet Greetings | lolcat -tp 1
          end
          
          if command -v fortune >/dev/null 2>&1
            fortune | lolcat -t
          end
          
          echo ""
          echo -e "Uptime:" (uptime) | lolcat
        else
          # Fallback if figlet/lolcat not available
          echo "Welcome back, "(whoami)"!"
          echo "Uptime:" (uptime)
        end
      '';

      # Custom sudo function for !!
      sudo = ''
        if test "$argv" = "!!"
          eval command sudo $history[1]
        else
          command sudo $argv
        end
      '';

      # Quick directory navigation (set these paths as needed)
      cf = ''
        cd "$CF" 2>/dev/null; or echo "CF directory not set. Set with: set -Ux CF /path/to/config"
      '';

      pjt = ''
        cd "$PJT" 2>/dev/null; or echo "PJT directory not set. Set with: set -Ux PJT /path/to/projects"
      '';

      rs = ''
        cd "$RS" 2>/dev/null; or echo "RS directory not set. Set with: set -Ux RS /path/to/rust"
      '';
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.tmux = { enable = true; };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "OneHalfDark";
      style = "changes,header,grid";
    };
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    colors = {
      fg = "#e5c07b";
      "fg+" = "#282c34";
      bg = "-1";
      "bg+" = "#61afef";
    };
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    icons = "auto";
    git = true;
  };

  # Essential packages
  home.packages = with pkgs; [
    # Bat extras
    bat-extras.batman
    bat-extras.batpipe
    bat-extras.batgrep
    bat-extras.batdiff

    # Development tools
    ripgrep
    fd
    jq
    htop

    # Fun greeting tools
    figlet
    lolcat
    fortune

  ];

  xdg.configFile = {
    "starship.toml".source = ../../.config/starship.toml;
    "tmux/tmux.conf".source = ../../.config/.tmux.conf;
  };
}
