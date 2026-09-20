{pkgs, config, ...}: let
  colors = config.lib.stylix.colors.withHashtag;
in {
  services.mako = {
    enable = true;
    settings = {
      # NOTE: font/colors are controlled by stylix
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

      # NOTE: urgency/critical accent colors are derived from the stylix
      # palette automatically by the stylix mako target.
      "urgency=normal" = {
        border-color = "${colors.base0E}";
      };
      "urgency=critical" = {
        default-timeout = 0; # stick around until dismissed
      };
      "category=spotify" = {
        border-color = "${colors.base0A}";
        default-timeout = 3000;
      };
      "app-name=firefox" = {
        border-color = "${colors.base0C}";
      };
      "mode=do-not-disturb" = {
        invisible = 1;
      };
    };
  };

  # Notification utilities
  home.packages = with pkgs; [
    libnotify # notify-send
  ];
}
