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
    platformTheme.name = "kvantum"; # Changed from "qtct" to "kvantum"
    style.name = "kvantum";
  };

  # Remove QT_STYLE_OVERRIDE if it exists
  home.sessionVariables = {
    QT_STYLE_OVERRIDE = lib.mkForce "";
  };

  xdg.configFile = {
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
