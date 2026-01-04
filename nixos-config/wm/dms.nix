{ pkgs, dms, ... }:

{
  imports = [ dms.homeModules.dankMaterialShell.default ];

  programs.dankMaterialShell = {
    enable = true;

    default.settings = {
      theme = "dark";
      dynamicTheming = true;
      # Add any other settings here
    };

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged =
        true; # Auto-restart dms.service when dankMaterialShell changes
    };

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableClipboard = true; # Clipboard history manager
    enableVPN = true; # VPN management widget
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)
  };

}
