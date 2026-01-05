{ pkgs, ... }:

{
  imports = [ ./niri.nix ./dms.nix ./gtk.nix ./qt.nix ];

  home.packages = with pkgs; [
    xwayland-satellite
    swaybg
    swaylock
    wl-clipboard
    cliphist
  ];
}
