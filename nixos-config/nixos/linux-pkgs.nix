{pkgs, ...}: {
  home.packages = with pkgs; [
    # Essential Apps
    firefox
    brave
    bitwarden-desktop
    qbittorrent
    discord

    bottom

    # Artist
    blender
    gimp
    krita

    # Utilities
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.filelight
  ];
}
