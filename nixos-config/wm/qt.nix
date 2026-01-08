{ pkgs, ... }:

{
  # Install Kvantum
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
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
    accent = "blue";
    flavor = "mocha";
  };
}
