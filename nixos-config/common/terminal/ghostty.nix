{ pkgs, lib, ... }:

# Ghostty is not available on nix darwin as of yet
lib.mkIf pkgs.stdenv.isLinux {
  home.packages = with pkgs; [ ghostty ];

  programs.ghostty = {
    enable = true;
    settings = {
      bold-is-bright = true;
      selection-invert-fg-bg = true;

      # Font
      font-size = 14;
      font-thicken = true;

      # Window Settings
      window-padding-x = 20;
      window-padding-y = 10;
      window-padding-color = "background";
      window-padding-balance = true;
      window-save-state = "always";
      window-colorspace = "display-p3";
      window-width = 120;
      window-height = 45;

      # Other Settings
      shell-integration-features = "no-cursor,sudo,no-title";
      adjust-cell-height = "15%";
      shell-integration = "fish";
      mouse-scroll-multiplier = 0.5;

      # Look and Feel
      background-blur = true;
      background-opacity = 0.8;
      adjust-cursor-thickness = 3;
      adjust-underline-position = 3;
      cursor-invert-fg-bg = true;
      cursor-opacity = 0.8;
      link-url = true;
      mouse-hide-while-typing = true;
      window-vsync = true;
      window-decoration = "none";

      # Keybindings
      keybind = [ "cmd+s>r=reload_config" "cmd+s>x=close_surface" ];
    };
  };
}
