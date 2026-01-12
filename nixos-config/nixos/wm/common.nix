{ pkgs, ... }:

{
  # Common packages shared between Niri and Hyprland
  home.packages = with pkgs; [
    # Screenshot utilities
    grim
    slurp

    # Clipboard
    wl-clipboard
    cliphist

    # Wallpaper
    swaybg

    # Media/brightness control
    playerctl
    brightnessctl

    # XWayland support
    xwayland-satellite

    # Icon theme for Rofi
    # papirus-icon-theme

    # Fonts - individual nerd-fonts packages (NixOS 24.05+)
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  # Set cursor theme
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 20;
    gtk.enable = true;
  };

  # Session variables for Wayland
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}
