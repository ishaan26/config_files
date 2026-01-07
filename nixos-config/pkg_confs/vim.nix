{ pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
  };

  # Required packages (AstroNvim requirements + core tools)
  home.packages = with pkgs; [
    # Core
    git
    lazygit
    ripgrep
    bottom
    gdu
    tree-sitter

    # Compilers / Runtimes
    gcc
    unzip
    wget
    curl
    gzip
    gnutar
    gnumake
  ];

  # Setup AstroNvim
  # 1. Clone AstroNvim template if not present
  # 2. Link our user config
  home.activation.installAstroNvim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "$HOME/.config/nvim" ]; then
      ${pkgs.git}/bin/git clone --depth 1 https://github.com/AstroNvim/template "$HOME/.config/nvim"
    fi

    # Check if the link exists or if it is a directory
    if [ -e "$HOME/.config/nvim/lua" ]; then
       if [ ! -L "$HOME/.config/nvim/lua" ]; then
          echo "Warning: Replacing $HOME/.config/nvim/lua with custom config"
          rm -rf "$HOME/.config/nvim/lua"
       fi
    fi

    # Re-link every time to ensure it points to the correct store path
    ln -sfn ${../../astronvim_config/lua} $HOME/.config/nvim/lua
  '';
}
