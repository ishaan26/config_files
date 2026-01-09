{ ... }: {
  environment.systemPackages = [
    (
      pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        accent = "blue";
        font = "Noto Sans";
        fontSize = "12";
        background = "${./Wallpaper.jpg}";
        loginBackground = true;
      }
    )
  ];

  # Set sddm in the displayManager.
  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha-blue";
    package = pkgs.kdePackages.sddm;
    wayland.enable = true;
  };
}
