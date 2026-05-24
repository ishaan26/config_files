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

    # LLM inference with AMD ROCm support
    # Wrapped to hide unsupported iGPU (gfx1036) from ROCm;
    # only the RX 7900 XT (gfx1100) is used
    (pkgs.symlinkJoin {
      name = "ollama-rocm-wrapped";
      buildInputs = [ pkgs.makeWrapper ];
      paths = [ pkgs.ollama-rocm ];
      postBuild = ''
        for bin in $out/bin/*; do
          wrapProgram "$bin" \
            --set ROCR_VISIBLE_DEVICES "0" \
            --set HSA_OVERRIDE_GFX_VERSION "11.0.0" \
            --set HIP_VISIBLE_DEVICES "0"
        done
      '';
    })
    (llama-cpp.override { rocmSupport = true; })

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
