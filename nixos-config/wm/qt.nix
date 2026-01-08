{ pkgs, ... }:

{
  home.packages = with pkgs; [
    libsForQt5.qt5ct
    kdePackages.qt6ct
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    catppuccin-kvantum
  ];

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  # 1. Set the theme name in the Kvantum config file
  # Note: The name here MUST match the folder name in step 2.
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=catppuccin-mocha-blue
  '';

  # 2. Link the theme assets from the Nix store
  # Correct Path: share/Kvantum/Catppuccin-Mocha-{Accent}
  xdg.configFile."Kvantum/catppuccin-mocha-blue".source = "${pkgs.catppuccin-kvantum}/share/Kvantum/catppuccin-mocha-blue";
}
