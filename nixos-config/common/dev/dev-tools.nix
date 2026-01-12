{ pkgs, lib, ... }:

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
}
