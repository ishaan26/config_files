{ config, pkgs, lib, ... }:

let
  # Configure your Catppuccin theme variant here
  variant = "mocha";
  accent = "mauve";

  # Create the Kvantum theme package with your chosen variant
  kvantumThemePackage =
    pkgs.catppuccin-kvantum.override { inherit variant accent; };
in {
  # Install necessary packages
  home.packages = with pkgs; [
    # Essential Qt and theming packages
    libsForQt5.qt5ct # More stable than qt6ct for theming
    libsForQt5.qtstyleplugin-kvantum

    # Icon themes
    papirus-icon-theme

    # Qt libraries
    libsForQt5.qtbase
    libsForQt5.qtsvg

    # Optional: Theme utilities for debugging
    lxappearance # GTK theme previewer
    qt6Packages.qtstyleplugin-kvantum # Qt6 version if needed
  ];

  # Configure Qt theming
  qt = {
    enable = true;
    platformTheme = "kde"; # Use qt5ct instead of qt6ct
    style.name = "kvantum-dark"; # Kvantum as the widget style
  };

  # Link Kvantum theme to the correct location
  xdg.configFile = {
    # 1. Main Kvantum configuration
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=catppuccin-${variant}-${accent}
    '';

    # 2. CRITICAL: Symlink the theme from Nix store to ~/.config/Kvantum
    "Kvantum/catppuccin-${variant}-${accent}".source =
      "${kvantumThemePackage}/share/Kvantum/catppuccin-${variant}-${accent}";

    # 3. Configure qt5ct appearance settings
    "qt5ct/qt5ct.conf".text = ''
      [Appearance]
      icon_theme=breeze-dark
      style=kvantum
      custom_palette=false

      [Fonts]
      fixed=Noto Sans,12,-1,5,50,0,0,0,0,0
      general=Noto Sans,12,-1,5,50,0,0,0,0,0
    '';
  };

  # Environment variables for Qt applications
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "kde"; # Force qt5ct as platform theme
    QT_STYLE_OVERRIDE = "kvantum-dark"; # Force kvantum style
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };
}
