{ pkgs, ... }:

{
  home.packages = with pkgs; [ libsForQt5.qt5ct kdePackages.qt6ct ];

  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
  };
}
