{ pkgs, ... }:
{
  services.mako = {
    enable = true;
    settings = {
      # Font
      font = "JetBrainsMono Nerd Font 11";
      # Catppuccin Mocha colors
      background-color = "#1e1e2eee";
      text-color = "#cdd6f4";
      border-color = "#cba6f7";
      progress-color = "over #89b4fa";
      # Dimensions
      width = 350;
      height = 150;
      margin = "12";
      padding = "12";
      border-size = 2;
      border-radius = 12;
      # Behavior
      default-timeout = 5000;
      ignore-timeout = false;
      max-visible = 5;
      layer = "overlay";
      anchor = "top-right";
      # Icons
      icons = true;
      max-icon-size = 48;
      # Actions
      actions = true;
    };
    # Extra config for urgency levels
    extraConfig = ''
      [urgency=low]
      border-color=#a6e3a1
      [urgency=normal]
      border-color=#cba6f7
      [urgency=critical]
      border-color=#f38ba8
      default-timeout=0
      [category=spotify]
      border-color=#a6e3a1
      default-timeout=3000
      [app-name=firefox]
      border-color=#89b4fa
      [mode=do-not-disturb]
      invisible=1
    '';
  };
  # Notification utilities
  home.packages = with pkgs; [
    libnotify  # notify-send
  ];
}
