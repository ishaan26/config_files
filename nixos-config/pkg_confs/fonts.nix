{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.zed-mono
    nerd-fonts.space-mono
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;
}
