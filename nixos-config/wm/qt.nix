{ pkgs, lib, ... }:

let
  variant = "mocha";
  accent = "teal";
  kvantumThemePackage =
    pkgs.catppuccin-kvantum.override { inherit variant accent; };
in
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=catppuccin-${variant}-${accent}
    '';

    # The important bit is here, links the theme directory from the package to a directory under ~/.config
    # where Kvantum should find it.
    "Kvantum/catppuccin-${variant}-${accent}".source =
      "${kvantumThemePackage}/share/Kvantum/catppuccin-${variant}-${accent}";

    "qt5ct/qt5ct.conf".text = ''
      [Appearance]
      style=kvantum
      icon_theme=Papirus-Dark
    '';

    "qt6ct/qt6ct.conf".text = ''
      [Appearance]
      style=kvantum
      icon_theme=Papirus-Dark
    '';
  };
}
