{ pkgs, lib, ... }:

let
  variant = "mocha";
  accent = "blue";
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
      translucent_windows=true
      reduce_window_opacity=10
      blurring=true
      contrast=1.00
      intensity=1.00
      saturation=1.00
      [Hacks]
      transparent_dolphin_view=true
      transparent_ktitle_label=true
      blur_translucent=true
      transparent_menutitle=false
      [WindowTranslucent]
      interior=true
      interior.element=window
      interior.x.patternsize=48
      interior.y.patternsize=48
      frame.expansion=0
    '';

    # The important bit is here, links the theme directory from the package to a directory under ~/.config
    # where Kvantum should find it.
    "Kvantum/catppuccin-${variant}-${accent}".source =
      "${kvantumThemePackage}/share/Kvantum/catppuccin-${variant}-${accent}";
  };
}
