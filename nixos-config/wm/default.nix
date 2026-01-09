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
    ./gtk.nix
    ./qt.nix
    ./awww.nix
    ./sddm.nix
  ];
}
