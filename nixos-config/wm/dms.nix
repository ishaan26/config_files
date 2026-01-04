{ pkgs, dms, ... }:

{
  imports = [
    dms.homeModules.dankMaterialShell.default
  ];

  programs.dankMaterialShell = {
    enable = true;
    # Not using niri-specific integration since we're using nixpkgs niri, not niri-flake
  };
}
