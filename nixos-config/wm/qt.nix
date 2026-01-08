{ pkgs, lib, ... }:
let
  variant = "mocha";
  accent = "blue";
  kvantumThemePackage = pkgs.catppuccin-kvantum.override {
    inherit variant accent;
  };
in
{
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
  };

  # Ensure these packages are installed
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    kdePackages.qt6ct
  ];

  xdg.configFile = {
    # Qt5ct configuration
    "qt5ct/qt5ct.conf".text = ''
      [Appearance]
      style=kvantum
      
      [Interface]
      stylesheets=@Invalid()
    '';

    # Qt6ct configuration  
    "qt6ct/qt6ct.conf".text = ''
      [Appearance]
      style=kvantum
      
      [Interface]
      stylesheets=@Invalid()
    '';

    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=catppuccin-${variant}-${accent}
    '';

    # Link the theme directory
    "Kvantum/catppuccin-${variant}-${accent}".source =
      "${kvantumThemePackage}/share/Kvantum/catppuccin-${variant}-${accent}";
  };
}
