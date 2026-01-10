{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs;
    [
      #####################################
      # Gui tools 
      #####################################
      # zed-editor
      antigravity
      vscode

      #####################################
      # Language tools
      #####################################
      # Rust
      rustup

      # Web
      nodejs
      bun
      deno

      # Python - basic installation
      python313
      python313Packages.pip
      python313Packages.virtualenv
      uv

      # Debugging tools (cross-platform)
      lldb
    ] ++ lib.optionals pkgs.stdenv.isLinux [
      # Linux-only tools
      gdb
      gcc
    ];

  # to use flakes for development
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;

    config = {
      # Optionally whitelist specific directories
      whitelist = {
        prefix = [
          "~/Documents/Github/" # Auto-allow all projects in this folder
        ];
      };
    };
  };

  home.sessionVariables = {
    # Rust
    CARGO_HOME = "$HOME/.cargo";
    CARGO_TARGET_DIR = "$HOME/.cargo/target-dump";
    RUSTUP_HOME = "$HOME/.rustup";

    # Python
    PYTHONPATH =
      "${config.home.homeDirectory}/.local/lib/python3.13/site-packages:$PYTHONPATH";
  };

  programs.fish.shellInit = ''
    # Add Python local bins to PATH
    set -gx PATH $HOME/.local/bin $PATH
  '';
}
