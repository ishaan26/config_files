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
    style.name = "kvantum";
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
  };
}
