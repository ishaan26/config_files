{pkgs, ...}: {
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
    image = ../wallpaper.png;
    polarity = "dark";

    fonts = {
      serif = {
        package = pkgs.aleo-fonts;
        name = "Aleo";
      };

      sansSerif = {
        package = pkgs.noto-fonts-cjk-sans;
        name = "Noto Sans CJK JP";
      };

      monospace = {
        package = pkgs.nerd-fonts.zed-mono;
        name = "ZedMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
