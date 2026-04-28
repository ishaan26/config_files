{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs;
    [
      #####################################
      # Language tools
      #####################################
      # Rust
      rustup
      cargo-update

      # Go
      go

      # Web
      nodejs
      bun
      svelte-language-server

      # Python - basic installation
      python313
      python313Packages.pip
      python313Packages.virtualenv
      uv

      # Nix
      nixd
      deadnix
      statix

      # Java (For Android development)
      jdk21

      #####################################
      # Cli tools
      #####################################
      gh
      hyperfine
      android-tools

      #####################################
      # Debugging tools
      #####################################
      lldb
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      # Linux-only tools
      gdb
      gcc

      #####################################
      # GUI tools
      #####################################
      github-desktop
    ];
}
