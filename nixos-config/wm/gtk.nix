{ pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };

    gtk3.extraCss = ''
      @import url("dank-colors.css");
    '';

    gtk4.extraCss = ''
      @import url("dank-colors.css");
    '';
  };
}
