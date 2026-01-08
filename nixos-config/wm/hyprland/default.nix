{ config, pkgs, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Variables
      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      "$launcher" = "rofi -show drun";
      "$fileManager" = "nautilus";
      "$browser" = "firefox";

      # Monitor configuration
      monitor = [ ",preferred,auto,1" ];

      # General settings - Catppuccin Mocha
      general = {
        gaps_in = 6;
        gaps_out = 12;
        border_size = 2;
        "col.active_border" = "rgb(cba6f7) rgb(89b4fa) 45deg";
        "col.inactive_border" = "rgb(45475a)";
        layout = "dwindle";
        resize_on_border = true;
      };

      # Decoration
      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 0.95;

        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = true;
          xray = false;
          popups = true;
          vibrancy = 0.5;
          vibrancy_darkness = 0.5;
        };

        shadow = {
          enabled = true;
          range = 5;
          render_power = 5;
        };
      };

      # Animations
      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint, 0.22, 1, 0.36, 1"
          "easeInOutQuint, 0.83, 0, 0.17, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];
        animation = [
          "windows, 1, 4, easeOutQuint, popin 80%"
          "windowsOut, 1, 4, easeOutQuint, popin 80%"
          "fade, 1, 3, easeOutQuint"
          "workspaces, 1, 4, easeOutExpo, slide"
        ];
      };

      # Input
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
          drag_lock = true;
          disable_while_typing = true;
        };
      };

      # Dwindle layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
      };

      # Master layout
      master = { new_status = "master"; };

      # Misc
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
      };

      # Startup applications
      exec-once = [ "waybar" "mako" ];

      # Window rules
      windowrulev2 = [
        "float,class:^(pavucontrol)$"
        "float,class:^(nm-connection-editor)$"
        "float,class:^(blueman-manager)$"
        "float,title:^(Picture-in-Picture)$"
        "float,class:^(xdg-desktop-portal-gtk)$"
        "opacity 0.9 0.85,class:^(ghostty)$"
      ];

      # Keybindings
      bind = [
        # Core applications
        "$mod, Return, exec, $terminal"
        "$mod, Space, exec, $launcher"
        "$mod, E, exec, $fileManager"
        "$mod, B, exec, $browser"
        "$mod, Q, killactive"
        "$mod ALT, L, exec, swaylock"
        "$mod ALT, W, exec, systemctl --user start awww-rotation.service"

        # Vim-style focus navigation (matching Niri)
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"

        # Vim-style window movement
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, j, movewindow, d"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, l, movewindow, r"

        # Workspace navigation
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"

        # Move window to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"

        # Special workspace (scratchpad)
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # Window management
        "$mod, F, fullscreen, 1"
        "$mod SHIFT, F, fullscreen, 0"
        "$mod, V, togglefloating"
        "$mod, P, pseudo"
        "$mod, T, togglesplit"
        "$mod, C, centerwindow"

        # Resize mode
        "$mod, R, submap, resize"

        # Screenshots
        ''
          , Print, exec, grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png''
        "CTRL, Print, exec, grim ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
        ''$mod SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy''

        # System
        "$mod SHIFT, E, exit"

        # Scroll through workspaces
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # Tab through workspaces
        "$mod, Tab, workspace, e+1"
        "$mod SHIFT, Tab, workspace, e-1"
      ];

      # Submap for resize mode
      # Note: This is handled via hyprland's submap functionality

      # Repeat bindings (for held keys)
      binde = [
        # Audio controls
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

        # Brightness controls
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"

        # Resize with arrow keys (in resize submap)
        "$mod CTRL, h, resizeactive, -20 0"
        "$mod CTRL, l, resizeactive, 20 0"
        "$mod CTRL, k, resizeactive, 0 -20"
        "$mod CTRL, j, resizeactive, 0 20"
      ];

      # Media keys
      bindl = [
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];

      # Mouse bindings
      bindm = [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];

      layerrule =
        [ "blur on, match:namespace waybar" "blur on, match:namespace rofi" ];
    };

    # Extra config for resize submap
    extraConfig = ''
      submap = resize
      binde = , h, resizeactive, -20 0
      binde = , l, resizeactive, 20 0
      binde = , k, resizeactive, 0 -20
      binde = , j, resizeactive, 0 20
      bind = , escape, submap, reset
      bind = , Return, submap, reset
      submap = reset
    '';
  };
}
