{ config, pkgs, ... }:

{
  xdg.configFile."niri/config.kdl".text = ''
    // Input device configuration.
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
        }
    }

    // Layout settings
    layout {
        gaps 16
        center-focused-column "never"
        
        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }
        
        default-column-width { proportion 0.5; }
        
        focus-ring {
            width 4
            active-color "#7fc8ff"
            inactive-color "#505050"
        }
        
        border {
            off
        }
    }

    // Startup programs
    spawn-at-startup "xwayland-satellite"

    // Screenshot path
    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    // Window rules
    window-rule {
        match app-id=r#"^org\.wezfurlong\.wezterm$"#
        default-column-width {}
    }

    // Keybindings
    binds {
        Mod+Shift+Slash { show-hotkey-overlay; }

        // Terminal and lock
        Mod+Return { spawn "ghostty"; }
        Mod+Alt+L { spawn "swaylock"; }

        // DankMaterialShell handles media keys, launcher, etc.

        Mod+Q { close-window; }

        // Focus navigation
        Mod+Left  { focus-column-left; }
        Mod+Down  { focus-window-down; }
        Mod+Up    { focus-window-up; }
        Mod+Right { focus-column-right; }
        
        Mod+Shift+Left  { move-column-left; }
        Mod+Shift+Down  { move-window-down; }
        Mod+Shift+Up    { move-window-up; }
        Mod+Shift+Right { move-column-right; }

        Mod+Home { focus-column-first; }
        Mod+End  { focus-column-last; }
        Mod+Ctrl+Home { move-column-to-first; }
        Mod+Ctrl+End  { move-column-to-last; }

        // Monitor navigation
        Mod+Ctrl+Left  { focus-monitor-left; }
        Mod+Ctrl+Down  { focus-monitor-down; }
        Mod+Ctrl+Up    { focus-monitor-up; }
        Mod+Ctrl+Right { focus-monitor-right; }

        Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }

        // Workspace navigation
        Mod+Page_Down      { focus-workspace-down; }
        Mod+Page_Up        { focus-workspace-up; }
        Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
        Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }

        Mod+Shift+Page_Down { move-workspace-down; }
        Mod+Shift+Page_Up   { move-workspace-up; }

        Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

        // Window management
        Mod+BracketLeft  { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }

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

        // System
        Mod+Shift+E { quit; }
        Mod+Shift+P { power-off-monitors; }
        // DMS Core Controls
        Mod+Space { spawn "dms" "ipc" "call" "spotlight" "toggle"; }
        Mod+V { spawn "dms" "ipc" "call" "clipboard" "toggle"; }
        Mod+M { spawn "dms" "ipc" "call" "processlist" "focusOrToggle"; }
        Mod+Comma { spawn "dms" "ipc" "call" "settings" "focusOrToggle"; }
        
        // Audio Controls
        XF86AudioRaiseVolume { spawn "dms" "ipc" "call" "audio" "increment" "3"; }
        XF86AudioLowerVolume { spawn "dms" "ipc" "call" "audio" "decrement" "3"; }
        XF86AudioMute { spawn "dms" "ipc" "call" "audio" "mute"; }
        
        // Brightness Controls
        XF86MonBrightnessUp { spawn "dms" "ipc" "call" "brightness" "increment" "5"; }
        XF86MonBrightnessDown { spawn "dms" "ipc" "call" "brightness" "decrement" "5"; }
    }
  '';
}
