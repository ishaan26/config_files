{ pkgs, lib, ... }:

{
  home.packages = with pkgs;
    [
      #####################################
      # Editors
      #####################################
      zed-editor
      antigravity
      vscode
      # neovim - switched this to a system package

      #####################################
      # Language tools
      #####################################
      # Rust
      rustup
      cargo-update

      # Web
      nodejs
      bun
      deno

      # Python - basic installation
      python313
      python313Packages.pip
      python313Packages.virtualenv
      uv

      #####################################
      # Cli tools
      #####################################
      gh

      #####################################
      # Debugging tools 
      #####################################
      lldb
    ] ++ lib.optionals pkgs.stdenv.isLinux [
      # Linux-only tools
      gdb
      gcc

      #####################################
      # GUI tools
      #####################################
      github-desktop
    ];
}
