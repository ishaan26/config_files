{
  config,
  pkgs,
  awww,
  ...
}: {
  home.packages = [awww.packages.${pkgs.stdenv.hostPlatform.system}.awww];

  systemd.user.services.awww-daemon = {
    Unit = {
      Description = "awww wallpaper daemon";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${awww.packages.${pkgs.stdenv.hostPlatform.system}.awww}/bin/awww-daemon";
      Restart = "on-failure";
    };
    Install = {WantedBy = ["graphical-session.target"];};
  };

  systemd.user.services.awww-rotation = {
    Unit = {
      Description = "Rotate wallpaper using awww";
      After = ["awww-daemon.service"];
    };
    Service = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "awww-rotate" ''
        WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
        if [ -d "$WALLPAPER_DIR" ]; then
          WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
          if [ -n "$WALLPAPER" ]; then
            ${
          awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
        }/bin/awww img "$WALLPAPER" --transition-type random --transition-step 90 --transition-fps 60
          fi
        fi
      '';
    };
    Install = {WantedBy = ["graphical-session.target"];};
  };

  systemd.user.timers.awww-rotation = {
    Unit = {Description = "Rotate wallpaper every 15 minutes";};
    Timer = {
      OnUnitActiveSec = "15m";
    };
    Install = {WantedBy = ["timers.target"];};
  };

  # Create initial wallpaper directory if it doesn't exist
  home.activation.createWallpaperDir = config.lib.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "$HOME/Pictures/Wallpapers"
  '';
}
