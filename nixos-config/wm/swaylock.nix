{ pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      # Appearance
      clock = true;
      indicator = true;
      indicator-radius = 120;
      indicator-thickness = 8;
      
      # Effects
      effect-blur = "10x3";
      effect-vignette = "0.5:0.5";
      fade-in = 0.2;
      
      # Grace period
      grace = 3;
      grace-no-mouse = true;
      grace-no-touch = true;
      
      # Date/time format
      datestr = "%A, %B %d";
      timestr = "%H:%M";
      
      # Font
      font = "JetBrainsMono Nerd Font";
      font-size = 24;
      
      # Catppuccin Mocha colors
      color = "1e1e2e";
      
      inside-color = "1e1e2e00";
      inside-clear-color = "1e1e2e00";
      inside-caps-lock-color = "1e1e2e00";
      inside-ver-color = "1e1e2e00";
      inside-wrong-color = "1e1e2e00";
      
      ring-color = "cba6f7";
      ring-clear-color = "a6e3a1";
      ring-caps-lock-color = "f9e2af";
      ring-ver-color = "89b4fa";
      ring-wrong-color = "f38ba8";
      
      key-hl-color = "89b4fa";
      bs-hl-color = "f38ba8";
      caps-lock-key-hl-color = "f9e2af";
      caps-lock-bs-hl-color = "f38ba8";
      
      line-color = "00000000";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";
      
      separator-color = "00000000";
      
      text-color = "cdd6f4";
      text-clear-color = "a6e3a1";
      text-caps-lock-color = "f9e2af";
      text-ver-color = "89b4fa";
      text-wrong-color = "f38ba8";
      
      # Layout text
      layout-text-color = "cdd6f4";
      
      # Ignore empty password
      ignore-empty-password = true;
      
      # Show failed attempts
      show-failed-attempts = true;
    };
  };

  # Idle daemon for auto-lock
  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock-effects}/bin/swaylock -f"; }
      { event = "lock"; command = "${pkgs.swaylock-effects}/bin/swaylock -f"; }
    ];
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock-effects}/bin/swaylock -f"; }
      { timeout = 600; command = "niri msg action power-off-monitors || hyprctl dispatch dpms off"; }
    ];
  };
}
