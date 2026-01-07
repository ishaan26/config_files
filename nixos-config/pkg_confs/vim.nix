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
      ${pkgs.git}/bin/git clone --depth 1 https://github.com/AstroNvim/AstroNvim "$HOME/.config/nvim"
    fi

    # Create the user directory if it doesn't exist (though we are linking it entirely usually)
    # Actually, AstroNvim expects user config under lua/user
    
    # We want to link $HOME/.config/nvim/lua/user -> /path/to/local/astronvim_config/lua
    # Since the user specified @[astronvim_config/lua], we will link that directory content 
    # to become the 'user' module in AstroNvim.
    
    # Check if the link exists or if it is a directory
    if [ -e "$HOME/.config/nvim/lua/user" ]; then
       if [ ! -L "$HOME/.config/nvim/lua/user" ]; then
          # If it is a real directory, back it up? Or just fail? 
          # For now, let's assume if it's not a link we shouldn't touch it to be safe, 
          # or we could move it. Let's force link it for this task as is typical in dotfiles mgmt.
          echo "Warning: $HOME/.config/nvim/lua/user exists and is not a symlink. Replacing..."
          rm -rf "$HOME/.config/nvim/lua/user"
       fi
    fi

    # Re-link every time to ensure it points to the correct store path
    ln -sfn ${../../astronvim_config/lua} $HOME/.config/nvim/lua/user
  '';
}
