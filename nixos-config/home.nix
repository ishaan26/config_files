{ pkgs, ... }:

{
  imports = [ ./pkg_confs ./wm ];

  home.username = "ishaan";
  home.homeDirectory = "/home/ishaan";

  # This value determines the Home Manager release that your
  # configuration is compatible with.
  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Packages that should be installed to the user profile
  home.packages = with pkgs; [
    # Essential Apps
    firefox
    brave
    bitwarden-desktop
    qbittorrent

    # Artist
    blender
    gimp
    krita
  ];

}
