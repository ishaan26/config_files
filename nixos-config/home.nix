{ config, pkgs, ... }:

{
  imports = [
    ./git-conf.nix
  ];
  
  home.username = "ishaan";
  home.homeDirectory = "/home/ishaan";
  
  # This value determines the Home Manager release that your
  # configuration is compatible with.
  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Packages that should be installed to the user profile
  home.packages = with pkgs; [
    # Add your user-specific packages here
   firefox
   brave
   ghostty
   bitwarden-desktop

   deadnix
   nixd
   statix
  ];

}
