{ pkgs, ... }:

{
  xdg.configFile."niri/config.kdl".text = ''
    // Environment variables
    environment {
        QT_QPA_PLATFORMTHEME "gtk3"
        QT_QPA_PLATFORM "wayland"
        NIXOS_OZONE_WL "1"
    }

    // Input configuration
    input {
        keyboard {
            xkb {
                layout "us"
            }
        }

        touchpad {
            tap
            dwt
            natural-scroll
            accel-speed 0.2
        }

        mouse {
            accel-speed 0.0
        }
    }

    // Layout settings - Catppuccin Mocha colors
    layout {
        gaps 12
        center-focused-column "never"

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }

        default-column-width { proportion 0.5; }

        focus-ring {
            width 2
            active-color "#cba6f7"
            inactive-color "#45475a"
        }

        border {
            off
        }

        struts {
            left 0
            right 0
            top 0
            bottom 0
        }
    }

    // Window rules
    window-rule {
        geometry-corner-radius 10
        clip-to-geometry true
    }

    // Startup applications
    spawn-at-startup "waybar"
    spawn-at-startup "mako"
    spawn-at-startup "swaybg" "-m" "fill" "-i" "${pkgs.catppuccin-wallpapers}/share/wallpapers/catppuccin/Colorful.jpeg"
    spawn-at-startup "xwayland-satellite"

    // Screenshot path
    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    // Additional window rules
    window-rule {
        match app-id=r#"^org\.wezfurlong\.wezterm$"#
        default-column-width {}
    }

    window-rule {
        match app-id=r#"^com\.mitchellh\.ghostty$"#
        default-column-width {}
    }

    // Keybindings
    binds {
        // Hotkey overlay
        Mod+Shift+Slash { show-hotkey-overlay; }

        // Core applications
        Mod+Return { spawn "ghostty"; }
        Mod+Space { spawn "rofi" "-show" "drun"; }
        Mod+E { spawn "nautilus"; }
        Mod+B { spawn "firefox"; }

        // Window management
        Mod+Q { close-window; }
        Mod+Alt+L { spawn "swaylock"; }

        // Vim-style focus navigation
        Mod+h { focus-column-left; }
        Mod+j { focus-window-down; }
        Mod+k { focus-window-up; }
        Mod+l { focus-column-right; }

        // Vim-style window movement
        Mod+Shift+h { move-column-left; }
        Mod+Shift+j { move-window-down; }
        Mod+Shift+k { move-window-up; }
        Mod+Shift+l { move-column-right; }

        // First/Last column
        Mod+Home { focus-column-first; }
        Mod+End { focus-column-last; }
        Mod+Ctrl+Home { move-column-to-first; }
        Mod+Ctrl+End { move-column-to-last; }

        // Monitor navigation
        Mod+Ctrl+h { focus-monitor-left; }
        Mod+Ctrl+j { focus-monitor-down; }
        Mod+Ctrl+k { focus-monitor-up; }
        Mod+Ctrl+l { focus-monitor-right; }

        Mod+Shift+Ctrl+h { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+j { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+k { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+l { move-column-to-monitor-right; }

        // Workspace navigation (1-9)
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }

        // Move window to workspace
        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }
        Mod+Shift+7 { move-column-to-workspace 7; }
        Mod+Shift+8 { move-column-to-workspace 8; }
        Mod+Shift+9 { move-column-to-workspace 9; }

        // Workspace scroll navigation
        Mod+Page_Down { focus-workspace-down; }
        Mod+Page_Up { focus-workspace-up; }
        Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
        Mod+Ctrl+Page_Up { move-column-to-workspace-up; }

        Mod+Shift+Page_Down { move-workspace-down; }
        Mod+Shift+Page_Up { move-workspace-up; }

        // Mouse wheel workspace navigation
        Mod+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp cooldown-ms=150 { focus-workspace-up; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Ctrl+WheelScrollUp cooldown-ms=150 { move-column-to-workspace-up; }

        // Column management
        Mod+BracketLeft { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }

        // Resize and layout
        Mod+R { switch-preset-column-width; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        Mod+C { center-column; }

        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }

        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        // Screenshots
        Print { screenshot; }
        Ctrl+Print { screenshot-screen; }
        Alt+Print { screenshot-window; }
        Mod+Shift+S { spawn "sh" "-c" "grim -g \"$(slurp)\" - | wl-copy"; }

        // System
        Mod+Shift+E { quit; }
        Mod+Shift+P { power-off-monitors; }

        // Audio controls (via wpctl)
        XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
        XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
        XF86AudioMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioMicMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

        // Brightness controls
        XF86MonBrightnessUp { spawn "brightnessctl" "set" "5%+"; }
        XF86MonBrightnessDown { spawn "brightnessctl" "set" "5%-"; }

        // Media controls
        XF86AudioPlay { spawn "playerctl" "play-pause"; }
        XF86AudioPrev { spawn "playerctl" "previous"; }
        XF86AudioNext { spawn "playerctl" "next"; }
    }
  '';
}
