{ pkgs, ... }:

{
  # Install Kvantum
  home.packages = with pkgs; [
    kdePackages.qt6ct
    kdePackages.qtbase
    kdePackages.qtwayland
    kdePackages.qtstyleplugin-kvantum
    kdePackages.breeze-icons
    kdePackages.qtimageformats
    kdePackages.qtsvg
  ];

  # Configure Qt to use Kvantum
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  # Enable Catppuccin theme for Kvantum
  catppuccin.kvantum = {
    enable = true;
    accent = "mauve";
    flavor = "mocha";
  };
}
