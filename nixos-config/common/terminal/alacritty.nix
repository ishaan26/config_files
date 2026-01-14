{ lib, ... }:
{
  programs.alacritty = {
    enable = true;

    settings = {
      # Window configuration
      window = {
        opacity = lib.mkForce 0.85;
        blur = true;
        decorations = "transparent"; # macOS: removes title bar but keeps rounded corners
        padding = {
          x = 20;
          y = 20;
        };
        dimensions = {
          columns = 180;
          lines = 50;
        };
        dynamic_padding = true;
        startup_mode = "Windowed";
        dynamic_title = true;
        option_as_alt = "Both"; # macOS: treat Option as Alt
      };

      # Scrolling
      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      # Font size (font family is set by Stylix)
      font = {
        size = lib.mkForce 18.0;
      };

      # Cursor
      cursor = {
        style = {
          shape = "Block";
          blinking = "Off";
        };
        unfocused_hollow = true;
      };

      # Mouse
      mouse = {
        hide_when_typing = true;
      };

      # Bell
      bell = {
        animation = "EaseOutExpo";
        duration = 0;
        color = "#ffffff";
      };

      # Selection
      selection = {
        save_to_clipboard = true;
      };

      # Live config reload
      general.live_config_reload = true;

      # Key bindings
      keyboard.bindings = [
        # Opacity adjustments
        { key = "Plus"; mods = "Command|Shift"; action = "IncreaseFontSize"; }
        { key = "Minus"; mods = "Command|Shift"; action = "DecreaseFontSize"; }
        { key = "Key0"; mods = "Command|Shift"; action = "ResetFontSize"; }

        # Font size adjustments
        { key = "Equals"; mods = "Command"; action = "IncreaseFontSize"; }
        { key = "Minus"; mods = "Command"; action = "DecreaseFontSize"; }
        { key = "Key0"; mods = "Command"; action = "ResetFontSize"; }

        # Clear screen
        { key = "K"; mods = "Command"; chars = "\\u000C"; }

        # New window
        { key = "N"; mods = "Command"; action = "CreateNewWindow"; }

        # Mac Options
        { key = "F"; mods = "Command|Shift"; action = "ToggleSimpleFullscreen"; }
      ];
    };
  };
}
