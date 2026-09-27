{ ... }:

{
  imports = [
    ./niri
    ./waybar
    ./vicinae
    ./mako.nix
    ./common.nix
    ./awww.nix
    # NOTE: The following settings are controlled by stylix
    # ./gtk.nix
    # ./qt.nix
  ];
}
