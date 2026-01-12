{ config, pkgs, ... }:

{
  # Import shared pkg_confs (cross-platform modules only)
  imports = [
    ./pkg_confs/shell.nix
    ./pkg_confs/git.nix
    ./pkg_confs/dev-tools.nix
    ./pkg_confs/vim.nix
    ./pkg_confs/tmux.nix
    ./pkg_confs/kitty.nix
    ./pkg_confs/alacritty.nix
  ];

  home.username = "ishaan";
  home.homeDirectory = "/Users/ishaan"; # macOS uses /Users, not /home!
  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Asrto nvim is irreplaceable
  stylix.targets.neovim.enable = false;

  # nh wrapper for nix commands
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake =
      "${config.home.homeDirectory}/Documents/Github/config_files/nixos-config"; # sets NH_OS_FLAKE variable for you
  };

  # Managed packages
  home.packages = with pkgs; [
    firefox
    brave
    bitwarden-desktop
  ];

  # macOS-specific session variables
  home.sessionVariables = {
    # Disable analytics
    HOMEBREW_NO_ANALYTICS = "1";
  };
}
