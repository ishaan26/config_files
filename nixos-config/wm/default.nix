{ pkgs, ... }:

{
  imports = [
    ./niri.nix
    ./dms.nix
  ];

  home.packages = with pkgs; [
    xwayland-satellite
    swaybg
    swaylock
    wl-clipboard
  ];
}
