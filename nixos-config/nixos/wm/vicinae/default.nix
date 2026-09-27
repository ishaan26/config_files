{ lib, ... }:

# Vicinae: Raycast-style launcher (apps, clipboard history, calculator, emoji,
# file search, window switcher, power commands, extensions). Runs as a daemon
# so the window opens instantly; toggle it with `vicinae toggle` or a deeplink
# such as `vicinae deeplink vicinae://launch/clipboard/history`.
#
# Colours, font and window opacity come from the stylix vicinae target.
{
  programs.vicinae = {
    enable = true;
    systemd.enable = true;

    settings = {
      telemetry.system_info = false;

      # Waybar already hosts the tray; settings live in the launcher itself.
      tray.enabled = false;

      pop_to_root_on_close = true;
      escape_key_behavior = "close_window";
      search_files_in_root = false;

      launcher_window = {
        # Translucent so niri's background blur shows through (stylix defaults
        # popups to fully opaque).
        opacity = lib.mkForce 0.92;
        rounding = 16;
        layer_shell = {
          enabled = true;
          layer = "top";
        };
      };

      favorites = [
        "clipboard:history"
        "files:search"
      ];
      fallbacks = [ "files:search" ];
    };
  };
}
