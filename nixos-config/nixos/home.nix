{
  pkgs,
  config,
  ...
}: {
  imports = [
    ../common/terminal
    ../common/dev
    ./wm
    ./linux-pkgs.nix
    ../common/neovim
  ];

  home = {
    username = "ishaan";
    homeDirectory = "/home/ishaan";

    # This value determines the Home Manager release that your
    # configuration is compatible with.
    stateVersion = "25.11";

    # Packages that should be installed to the user profile
    packages = with pkgs; [
      # Essential Apps
      firefox
      brave
      bitwarden-desktop
      qbittorrent

      # Artist
      blender
      gimp
      krita
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Astronvim cannot be repalced
  stylix.targets.neovim.enable = false;

  # Set Icon Theme
  stylix.icons = {
    enable = true;
    package = pkgs.papirus-icon-theme;
    dark = "Papirus-Dark";
    light = "Papirus-Light";
  };

  # An awsome wrapper for nix commands
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "${config.home.homeDirectory}/Documents/Github/config_files/nixos-config"; # sets NH_OS_FLAKE variable for you
  };
}
