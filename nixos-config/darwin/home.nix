{ config, ... }:

{
  imports = [
    ../common/terminal
    ../common/dev
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

  # macOS-specific session variables
  home.sessionVariables = {
    # Disable analytics
    HOMEBREW_NO_ANALYTICS = "1";
  };
}
