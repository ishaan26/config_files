{ pkgs, config, ... }:
{
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

    # Editors
    antigravity
    vscode

    # Utilities
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.filelight

    # Fix for pi install command
    (pkgs.symlinkJoin {
      name = "pi-coding-agent";
      buildInputs = [ pkgs.makeWrapper ];
      paths = [ pkgs.pi-coding-agent ];
      postBuild = ''
        wrapProgram $out/bin/pi \
          --set NPM_CONFIG_PREFIX ${config.home.homeDirectory}/.pi/npm/ \
          --prefix PATH : ${
            pkgs.lib.makeBinPath [
              pkgs.nodejs_latest
            ]
          }
      '';
    })

  ];
}
