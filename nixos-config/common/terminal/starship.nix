{config, ...}: let
  colors = config.lib.stylix.colors;
in {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      scan_timeout = 10;
      command_timeout = 500;

      format = builtins.concatStringsSep "" [
        "$os"
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_status"
        "$git_state"
        "$git_metrics"
        "$fill"
        "$nix_shell"
        "$docker_context"
        "$python"
        "$nodejs"
        "$rust"
        "$golang"
        "$php"
        "$java"
        "$lua"
        "$zig"
        "$package"
        "$cmd_duration"
        "$line_break"
        "$character"
      ];

      # -----------------------------------------------------------------------
      #  Utility / Layout
      # -----------------------------------------------------------------------
      fill = {
        symbol = " ";
      };

      character = {
        success_symbol = "[❯](bold #${colors.base0B})";
        error_symbol = "[❯](bold #${colors.base08})";
        vimcmd_symbol = "[❮](bold #${colors.base0B})";
      };

      cmd_duration = {
        min_time = 2000;
        format = "took [$duration](bold #${colors.base0A}) ";
      };

      # -----------------------------------------------------------------------
      #  System Identity
      # -----------------------------------------------------------------------
      os = {
        disabled = false;
        style = "bold #${colors.base05}";
        format = "[$symbol]($style)";
        symbols = {
          Macos = " ";
          Linux = " ";
          NixOS = " ";
        };
      };

      username = {
        show_always = false; # Clean look, only show if SSH or forceful
        style_user = "bold #${colors.base0D}";
        style_root = "bold #${colors.base08}";
        format = "[$user]($style) ";
      };

      hostname = {
        ssh_only = true;
        style = "bold #${colors.base0D}";
        format = "on [$hostname]($style) ";
        trim_at = ".";
      };

      directory = {
        style = "bold #${colors.base0D}"; # Blue
        read_only = " ";
        truncation_length = 3;
        truncate_to_repo = false;
        fish_style_pwd_dir_length = 1;
        format = "[$path]($style)[$read_only]($style) ";
      };

      # -----------------------------------------------------------------------
      #  Git
      # -----------------------------------------------------------------------
      git_branch = {
        symbol = " ";
        style = "bold #${colors.base0E}"; # Purple
        format = "at [$symbol$branch]($style) ";
      };

      git_status = {
        style = "bold #${colors.base08}"; # Red
        format = "([\\[ $all_status$ahead_behind\\]]($style) )";

        # Status Symbols & Counts
        conflicted = "[🏳 $count](bold red) ";
        ahead = " \${count}";
        behind = " \${count}";
        diverged = "󱓌 \${ahead_count}⇣\${behind_count}";
        up_to_date = "[ ](bold green)";
        untracked = "[ $count](bold blue) ";
        stashed = "[ $count](bold cyan) ";
        modified = "[ $count](bold yellow) ";
        staged = "[ $count](bold green) ";
        renamed = "[󰑕 $count](bold purple) ";
        deleted = "[󰆴 $count](bold red) ";
      };

      git_metrics = {
        disabled = false;
      };

      # -----------------------------------------------------------------------
      #  Languages
      # -----------------------------------------------------------------------

      python = {
        symbol = " ";
        style = "bold #FFD43B"; # Python Yellow
        format = "[$symbol$version]($style) ";
      };

      nodejs = {
        symbol = " ";
        style = "bold #339933"; # Node Green
        format = "[$symbol$version]($style) ";
      };

      rust = {
        symbol = " ";
        style = "bold #CE412B"; # Rust Red
        format = "[$symbol$version]($style) ";
      };

      golang = {
        symbol = " ";
        style = "bold #00ADD8"; # Go Blue
        format = "[$symbol$version]($style) ";
      };

      php = {
        symbol = " ";
        style = "bold #777BB4"; # PHP Purple
        format = "[$symbol$version]($style) ";
      };

      java = {
        symbol = " ";
        style = "bold #F89820"; # Java Orange
        format = "[$symbol$version]($style) ";
      };

      lua = {
        symbol = " ";
        style = "bold #51a0cf"; # Lua Blue
        format = "[$symbol$version]($style) ";
      };

      zig = {
        symbol = " ";
        style = "bold #F7A41D"; # Zig Orange
        format = "[$symbol$version]($style) ";
      };

      # -----------------------------------------------------------------------
      #  Tools & Env
      # -----------------------------------------------------------------------

      nix_shell = {
        disabled = false;
        symbol = "";
        style = "bold #5277C3"; # NixOS Dark Blue
        impure_msg = "";
        pure_msg = "[pure shell](bold green)";
        unknown_msg = "[unknown shell](bold yellow)";
        format = "via [$symbol$state( \\($name\\))]($style) ";
      };

      package = {
        symbol = "󰏓 ";
        format = "| [$symbol$version]($style) ";
      };

      docker_context = {
        symbol = " ";
        style = "bold #${colors.base0C}"; # Cyan
        format = "[$symbol$context]($style) ";
      };
    };
  };
}
