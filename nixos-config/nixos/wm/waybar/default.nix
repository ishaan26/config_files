{ ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false; # We start it from compositor config
    };

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 42;
        spacing = 2;
        margin-top = 6;
        margin-left = 12;
        margin-right = 12;

        modules-left = [ "clock" "niri/window" "hyprland/window" ];

        modules-center = [ "niri/workspaces" "hyprland/workspaces" ];

        modules-right =
          [ "tray" "pulseaudio" "network" "battery" "custom/power" ];

        # Workspaces
        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "󰇊";
            "2" = "󰇋";
            "3" = "󰇌";
            "4" = "󰇍";
            "5" = "󰇎";
            "6" = "󰇏";
          };
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
            "6" = [ ];
          };
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "󰇊";
            "2" = "󰇋";
            "3" = "󰇌";
            "4" = "󰇍";
            "5" = "󰇎";
            "6" = "󰇏";
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
        };

        # Window title
        "niri/window" = {
          format = "{}";
          max-length = 40;
          rewrite = {
            "(.*) — Mozilla Firefox" = "󰈹 $1";
            "(.*) - Visual Studio Code" = "󰨞 $1";
          };
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 40;
          rewrite = {
            "(.*) — Mozilla Firefox" = "󰈹 $1";
            "(.*) - Visual Studio Code" = "󰨞 $1";
          };
        };

        # Clock
        clock = {
          format = "󰥔 {:%H:%M}";
          format-alt = "󰃭 {:%A, %B %d, %Y}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#cba6f7'><b>{}</b></span>";
              days = "<span color='#cdd6f4'>{}</span>";
              weeks = "<span color='#89b4fa'><b>W{}</b></span>";
              weekdays = "<span color='#f9e2af'><b>{}</b></span>";
              today = "<span color='#a6e3a1'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        # Tray
        tray = {
          icon-size = 18;
          spacing = 8;
        };

        # PulseAudio
        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "󰂯 {volume}%";
          format-bluetooth-muted = "󰂲";
          format-muted = "󰝟";
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰋎";
            headset = "󰋎";
            phone = "󰏲";
            portable = "󰏲";
            car = "󰄋";
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-right = "pavucontrol";
          tooltip-format = "{desc} | {volume}%";
        };

        # Network
        network = {
          format-wifi = "󰤨 {signalStrength}%";
          format-ethernet = "󰈀";
          format-linked = "󰈀 (No IP)";
          format-disconnected = "󰤭";
          format-alt = "{essid} ({signalStrength}%)";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}";
          tooltip-format-wifi = "{essid} ({signalStrength}%): {ipaddr}/{cidr}";
          tooltip-format-ethernet = "{ifname}: {ipaddr}/{cidr}";
          on-click-right = "nm-connection-editor";
        };

        # Battery
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰂄 {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          tooltip-format = "{capacity}% - {timeTo}";
        };

        # Power menu
        "custom/power" = {
          format = "󰐥";
          tooltip = false;
          on-click = "rofi -show power-menu -modi power-menu:rofi-power-menu";
        };
      };
    };

    style = builtins.readFile ./style.css;
  };
}
