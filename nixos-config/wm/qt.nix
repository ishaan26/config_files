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
    platformTheme.name = "qtct"; # Back to qtct
    style.name = "";
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

    # Override the theme's kvconfig file to fix transparency issues
    "Kvantum/catppuccin-${variant}-${accent}/catppuccin-${variant}-${accent}.kvconfig".text =
      builtins.readFile "${kvantumThemePackage}/share/Kvantum/catppuccin-${variant}-${accent}/catppuccin-${variant}-${accent}.kvconfig"
      + ''

        [%General]
        reduce_window_opacity=0
        reduce_menu_opacity=0

        [Hacks]
        transparent_dolphin_view=false
        transparent_ktitle_label=false
        transparent_pcmanfm_sidepane=false
        transparent_pcmanfm_view=false
      '';
  };
}
