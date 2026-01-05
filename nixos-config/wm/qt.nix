{ pkgs, ... }:

{
  home.packages = with pkgs; [ libsForQt5.qt5ct kdePackages.qt6ct ];

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
  };
}
