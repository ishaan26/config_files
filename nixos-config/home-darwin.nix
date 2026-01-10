{ pkgs, config, ... }:

{
  # Import shared pkg_confs (cross-platform modules only)
  imports = [
    ./pkg_confs/shell.nix
    ./pkg_confs/git.nix
    ./pkg_confs/terminal.nix
    ./pkg_confs/dev-tools.nix
    ./pkg_confs/vim.nix
    ./pkg_confs/fonts.nix
    ./pkg_confs/tmux.nix
  ];

  home.username = "ishaan";
  home.homeDirectory = "/Users/ishaan"; # macOS uses /Users, not /home!
  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # nh wrapper for nix commands
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake =
      "${config.home.homeDirectory}/Documents/Github/config_files/nixos-config"; # sets NH_OS_FLAKE variable for you
  };

  # macOS-compatible packages
  home.packages = with pkgs; [
    # Browsers
    firefox

    # NOTE: The following may work better via Homebrew on macOS:
    # - brave (use: brew install --cask brave-browser)
    # - bitwarden-desktop (use: brew install --cask bitwarden)
    # - qbittorrent (use: brew install --cask qbittorrent)

    # Creative apps
    blender
    gimp
    # krita # May need Homebrew on macOS
  ];

  # macOS-specific session variables
  home.sessionVariables = {
    # Disable analytics
    HOMEBREW_NO_ANALYTICS = "1";
  };
}
