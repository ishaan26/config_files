{ pkgs, ... }:

{
  services.mako = {
    enable = true;

    # Font
    font = "JetBrainsMono Nerd Font 11";

    # Catppuccin Mocha colors
    backgroundColor = "#1e1e2eee";
    textColor = "#cdd6f4";
    borderColor = "#cba6f7";
    progressColor = "over #89b4fa";

    # Dimensions
    width = 350;
    height = 150;
    margin = "12";
    padding = "12";
    borderSize = 2;
    borderRadius = 12;

    # Behavior
    defaultTimeout = 5000;
    ignoreTimeout = false;
    maxVisible = 5;
    layer = "overlay";
    anchor = "top-right";

    # Icons
    icons = true;
    maxIconSize = 48;

    # Actions
    actions = true;

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
