{ pkgs, ... }:

{
  imports = [
    ./niri
    ./hyprland
    ./waybar
    ./rofi
    ./sddm
    ./mako.nix
    ./swaylock.nix
    ./common.nix
    ./gtk.nix
    ./qt.nix
    ./awww.nix
  ];
}
