{ config, ... }:
{
  stylix.targets.waybar.enable = true;
  programs.waybar = {
    enable = true;
    style = import ./style.nix {
      colors = config.lib.stylix.colors;
    };
    systemd = {
      enable = false; # We start it from compositor config
    };

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 44;
        spacing = 0;
        margin-top = 8;
        margin-left = 10;
        margin-right = 10;
        margin-bottom = 0;

        # Module layout
        modules-left = [
          "custom/logo"
          "custom/separator"
          "clock"
          "custom/separator"
          "mpris"
          "custom/separator"
          "hyprland/window"
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "idle_inhibitor"
          "custom/separator"
          "tray"
          "custom/separator"
          "group/hardware"
          "custom/separator"
          "group/system"
          "custom/separator"
          "custom/power"
        ];

        # ============================================================
        # LEFT MODULES
        # ============================================================

        # NixOS Logo
        "custom/logo" = {
          format = "󱄅 ";
          tooltip = true;
          tooltip-format = "  NixOS\n 󰍛  {}";
          exec = "cat /etc/os-release | grep PRETTY_NAME | cut -d '\"' -f 2";
          interval = 86400;
        };

        # Enhanced Clock with calendar
        clock = {
          format = "󰥔  {:%H:%M}";
          format-alt = "󰃭  {:%A, %B %d}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#fb9fb1'><b>{}</b></span>";
              days = "<span color='#d0d0d0'>{}</span>";
              weeks = "<span color='#6fc2ef'><b>W{}</b></span>";
              weekdays = "<span color='#ddb26f'><b>{}</b></span>";
              today = "<span color='#acc267'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        # Media Player
        mpris = {
          format = "{player_icon} {dynamic}";
          format-paused = "{status_icon} <i>{dynamic}</i>";
          dynamic-order = [
            "title"
            "artist"
          ];
          dynamic-len = 35;
          player-icons = {
            default = "󰐊";
            mpv = "󰝚 ";
            firefox = "󰈹 ";
            spotify = "󰓇 ";
            chromium = " ";
          };
          status-icons = {
            paused = "󰏤";
            playing = "󰐊";
            stopped = "󰓛";
          };
          tooltip-format = "󰎈 {player}\n󰝚 {title}\n󰠃 {artist}\n󰀥 {album}\n󰁫 {position}/{length}";
          on-click = "playerctl play-pause";
          on-click-right = "playerctl next";
          on-click-middle = "playerctl previous";
          on-scroll-up = "playerctl volume 0.05+";
          on-scroll-down = "playerctl volume 0.05-";
        };

        # Window title - Niri
        "niri/window" = {
          format = "{}";
          max-length = 50;
          rewrite = {
            "(.*) — Mozilla Firefox" = "󰈹 $1";
            "(.*) - Visual Studio Code" = "󰨞 $1";
            "(.*) - Zed" = " $1";
            "(.*) — Obsidian(.*)?" = "󱓧 $1";
            "nvim (.*)" = " $1";
            "fish (.*)" = "󰈺 $1";
            "" = "󰇄 Desktop";
          };
        };

        # Window title - Hyprland
        "hyprland/window" = {
          format = "{}";
          max-length = 50;
          rewrite = {
            "(.*) — Mozilla Firefox" = "󰈹 $1";
            "(.*) - Visual Studio Code" = "󰨞 $1";
            "(.*) - Zed" = " $1";
            "(.*) — Obsidian(.*)?" = "󱓧 $1";
            "nvim (.*)" = " $1";
            "fish (.*)" = "󰈺 $1";
            "" = "󰇄 Desktop";
          };
        };

        # ============================================================
        # CENTER MODULES
        # ============================================================

        # Workspaces - Hyprland
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "󰇊 ";
            "2" = "󰇋 ";
            "3" = "󰇌 ";
            "4" = "󰇍 ";
            "5" = "󰇎 ";
            "6" = "󰇏 ";
            active = "󰮯 ";
            default = "󰊠 ";
            urgent = "󰀨 ";
          };
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
            "6" = [ ];
          };
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e-1";
          on-scroll-down = "hyprctl dispatch workspace e+1";
          sort-by-number = true;
          all-outputs = false;
        };

        # ============================================================
        # RIGHT MODULES
        # ============================================================

        # Idle inhibitor (caffeine mode)
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶 ";
            deactivated = "󰾪 ";
          };
          tooltip-format-activated = "󰅶 Idle inhibitor: ON\nScreen will not turn off";
          tooltip-format-deactivated = "󰾪 Idle inhibitor: OFF\nNormal power saving enabled";
        };

        # System tray
        tray = {
          icon-size = 18;
          spacing = 10;
          show-passive-items = true;
        };

        # Hardware group (CPU, Memory, Disk, Temperature)
        "group/hardware" = {
          orientation = "horizontal";
          modules = [
            "cpu"
            "memory"
            "disk"
            "temperature"
          ];
        };

        temperature = {
          format = "{icon} {temperatureC}󰔄 ";
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          format-icons = [
            " "
            ""
            ""
            ""
            ""
          ];
          critical-threshold = 80;
          tooltip-format = " CPU Temperature: {temperatureC}°C / {temperatureF}°F";
        };

        cpu = {
          format = "  {usage}%";
          interval = 2;
          tooltip-format = "  CPU Usage: {usage}%\n󱛡 Load: {load}\n Processes: {processes}";
          on-click = "alacritty -e btm";
        };

        memory = {
          format = "  {percentage}%";
          interval = 5;
          tooltip-format = "  RAM: {used:0.1f}GiB / {total:0.1f}GiB ({percentage}%)\n  Swap: {swapUsed:0.1f}GiB / {swapTotal:0.1f}GiB ({swapPercentage}%)";
          on-click = "alacritty -e btm";
        };

        disk = {
          format = "󰋊 {percentage_used}%";
          interval = 30;
          path = "/";
          tooltip-format = "󰋊 Disk Usage: {used} / {total} ({percentage_used}%)\n Free: {free}";
          on-click = "nautilus";
        };

        # System group (Network, Bluetooth, Audio, Backlight, Battery)
        "group/system" = {
          orientation = "horizontal";
          modules = [
            "network"
            "bluetooth"
            "pulseaudio"
            "pulseaudio#microphone"
            "backlight"
            "battery"
          ];
        };

        # Network
        network = {
          format-wifi = "󰤨 {signalStrength}%";
          format-ethernet = "󰈀 ";
          format-linked = "󰈀 (No IP)";
          format-disconnected = "󰤭";
          format-disabled = "󰤮";
          format-alt = "󰩟 {bandwidthDownBytes}  {bandwidthUpBytes}";
          tooltip-format = "󰈀 {ifname}: {ipaddr}/{cidr}\n󰩠 Gateway: {gwaddr}\n󰓅 Speed: {bandwidthDownBits} ↓ {bandwidthUpBits} ↑";
          tooltip-format-wifi = "󰤨 {essid} ({signalStrength}%)\n󰈀 {ifname}: {ipaddr}/{cidr}\n󰓅 Speed: {bandwidthDownBits} ↓ {bandwidthUpBits} ↑";
          tooltip-format-ethernet = "󰈀 {ifname}: {ipaddr}/{cidr}\n󰓅 Speed: {bandwidthDownBits} ↓ {bandwidthUpBits} ↑";
          tooltip-format-disconnected = "󰤭 Disconnected";
          on-click = "nm-connection-editor";
          on-click-right = "alacritty -e nmtui";
          interval = 5;
        };

        # Bluetooth
        bluetooth = {
          format = "󰂯";
          format-connected = "󰂱 {num_connections}";
          format-connected-battery = "󰂱 {device_battery_percentage}%";
          format-disabled = "󰂲";
          format-off = "󰂲";
          tooltip-format = "󰂯 {controller_alias}\n󰂴 {controller_address}";
          tooltip-format-connected = "󰂱 {controller_alias}\n󰂴 {controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "󰥰 {device_alias}";
          tooltip-format-enumerate-connected-battery = "󰥰 {device_alias} ({device_battery_percentage}%)";
          on-click = "blueman-manager";
        };

        # PulseAudio
        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "󰂰 {volume}%";
          format-bluetooth-muted = "󰂲 Muted";
          format-muted = "󰝟";
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰋎";
            headset = "󰋎";
            phone = "󰏲";
            portable = "󰏲";
            car = "󰄋";
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-right = "pavucontrol";
          on-scroll-up = "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          tooltip-format = "󰓃 {desc}\n󰎈 Volume: {volume}%";
        };

        # Microphone
        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          on-click-right = "pavucontrol -t 4";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-";
          tooltip-format = "󰍬 Microphone: {volume}%";
        };

        # Backlight
        backlight = {
          format = "{icon} {percent}%";
          format-icons = [
            "󰃞"
            "󰃟"
            "󰃠"
          ];
          tooltip-format = "󰃠 Brightness: {percent}%";
          on-scroll-up = "brightnessctl set 5%+";
          on-scroll-down = "brightnessctl set 5%-";
          on-click = "brightnessctl set 50%";
        };

        # Battery with enhanced states and power profiles
        battery = {
          states = {
            full = 100;
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰂄 {capacity}%";
          format-full = "󰁹 Full";
          format-alt = "{icon} {time}";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          tooltip-format = "󰁹 Battery: {capacity}%\n󰥔 Time: {time}\n Health: {health}%\n󱐋 Power: {power:.2f}W\n󰈙 Cycles: {cycles}";
          on-click-right = "powerprofilesctl set $(powerprofilesctl list | rofi -dmenu -p ' Power Profile')";
        };

        # Power button with menu
        "custom/power" = {
          format = "󰐥";
          tooltip = true;
          tooltip-format = "󰐥 Power Menu\n\n󰤄 Lock\n󰍃 Logout\n󰜉 Reboot\n  Shutdown";
          on-click = "rofi -show power-menu -modi power-menu:rofi-power-menu";
        };

        # Separator
        "custom/separator" = {
          format = "│";
          interval = "once";
          tooltip = false;
        };
      };

      # Secondary bar for extra info (optional)
      secondaryBar = {
        layer = "top";
        position = "bottom";
        height = 36;
        margin-left = 32;
        margin-right = 32;
        margin-bottom = 6;
        spacing = 0;

        modules-left = [
          "custom/weather"
          "custom/separator"
          "custom/spotify"
        ];

        modules-center = [
          "wlr/taskbar"
        ];

        modules-right = [
          "custom/clipboard"
          "custom/separator"
          "custom/screenshot"
          "custom/separator"
          "custom/colorpicker"
          "custom/separator"
          "keyboard-state"
        ];

        # Weather module
        "custom/weather" = {
          format = "{}";
          interval = 1800;
          exec = "curl -s 'wttr.in/?format=1' 2>/dev/null || echo '󰖐 N/A'";
          tooltip = true;
          tooltip-format = "{}";
          on-click = "xdg-open 'https://wttr.in'";
        };

        # Spotify-specific module
        "custom/spotify" = {
          format = "󰓇 {}";
          max-length = 40;
          interval = 1;
          exec = "playerctl -p spotify metadata --format '{{artist}} — {{title}}' 2>/dev/null || echo ''";
          exec-if = "pgrep spotify";
          on-click = "playerctl -p spotify play-pause";
          on-click-right = "playerctl -p spotify next";
          on-click-middle = "playerctl -p spotify previous";
          on-scroll-up = "playerctl -p spotify volume 0.05+";
          on-scroll-down = "playerctl -p spotify volume 0.05-";
        };

        # Taskbar
        "wlr/taskbar" = {
          format = "{icon}";
          icon-size = 18;
          tooltip-format = "{title}";
          on-click = "activate";
          on-click-middle = "close";
          on-click-right = "minimize-raise";
        };

        # Clipboard
        "custom/clipboard" = {
          format = "󱉫";
          tooltip = true;
          tooltip-format = "󱉫 Clipboard History";
          on-click = "cliphist list | rofi -dmenu -p '󱉫 Clipboard' | cliphist decode | wl-copy";
          on-click-right = "cliphist wipe && notify-send '󱉫 Clipboard' 'History cleared'";
        };

        # Screenshot
        "custom/screenshot" = {
          format = "󰄀";
          tooltip = true;
          tooltip-format = "󰄀 Screenshot\n\n Left: Region\n Right: Full Screen";
          on-click = "grim -g \"$(slurp)\" - | wl-copy && notify-send '󰄀 Screenshot' 'Region copied to clipboard'";
          on-click-right = "grim - | wl-copy && notify-send '󰄀 Screenshot' 'Full screen copied to clipboard'";
        };

        # Color picker
        "custom/colorpicker" = {
          format = "󰏘";
          tooltip = true;
          tooltip-format = "󰏘 Color Picker";
          on-click = "hyprpicker -a -n";
        };

        # Keyboard state
        keyboard-state = {
          numlock = true;
          capslock = true;
          format = {
            numlock = "󰎦 {icon}";
            capslock = "󰘲 {icon}";
          };
          format-icons = {
            locked = "󰔒";
            unlocked = "󰨙";
          };
        };

        "custom/separator" = {
          format = "·";
          interval = "once";
          tooltip = false;
        };
      };
    };

  };
}
