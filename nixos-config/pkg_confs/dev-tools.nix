{ config, pkgs, ... }:

{
  home.packages = with pkgs; [

    #####################################
    # Gui tools 
    #####################################
    zed-editor
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

    # Development tools that work with both
    lldb # Debugger
    gdb
    gcc
  ];

  home.sessionVariables = {
    # Rust
    CARGO_HOME = "${config.home.homeDirectory}/.cargo";
    CARGO_TARGET_DIR = "${config.home.homeDirectory}/.cargo/target-dump";
    RUSTUP_HOME = "${config.home.homeDirectory}/.rustup";

    # Python
    PYTHONPATH =
      "${config.home.homeDirectory}/.local/lib/python3.13/site-packages:$PYTHONPATH";
  };

  programs.fish.shellInit = ''
    # Add Python local bins to PATH
    set -gx PATH $HOME/.local/bin $PATH
  '';
}
