{
  pkgs,
  config,
  lib,
  ...
}:
let
  # ROCm (AMD compute) only supports x86_64; Vetala is aarch64
  isX86 = pkgs.stdenv.hostPlatform.isx86_64;
in
{
  home.packages =
    with pkgs;
    [
      # Essential Apps
      firefox
      brave
      bitwarden-desktop
      qbittorrent

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
    ]
    ++ lib.optionals isX86 [
      # discord ships no aarch64-linux build
      discord

      # LLM inference with AMD ROCm support.
      # Wrapped to hide the unsupported iGPU (gfx1036) from ROCm;
      # only the RX 7900 XT (gfx1100) is used.
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
    ];
}
