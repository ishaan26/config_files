{ pkgs, ... }:

{
  imports = [
    ./niri
    ./hyprland
    ./waybar
    ./rofi
    ./mako.nix
    ./swaylock.nix
    ./common.nix
    ./awww.nix
    # NOTE: The following settings are controlled by stylix
    # ./gtk.nix
    # ./qt.nix
  ];
}
