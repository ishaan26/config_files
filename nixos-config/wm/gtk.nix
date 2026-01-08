{ pkgs, ... }:

{
  gtk = {
    enable = true;

    # Catppuccin Mocha GTK theme
    theme = {
      name = "catppuccin-mocha-blue-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        variant = "mocha";
      };
    };

    # Icon theme
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    # Cursor theme
    cursorTheme = {
      name = "catppuccin-mocha-dark-cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 24;
    };

    # GTK3 settings
    gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };

    # GTK4 settings
    gtk4.extraConfig = { gtk-application-prefer-dark-theme = true; };
  };

  # Ensure dconf works properly
  dconf.settings = {
    "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
  };

  # Install dconf for GTK settings
  home.packages = with pkgs; [ dconf ];
}
