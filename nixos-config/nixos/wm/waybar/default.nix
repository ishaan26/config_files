# Waybar for niri — two floating glass bars.
#
#   top   ┌──────────────────────────────────────────────────────────────────────┐
#         │ 󱄅 1 2 3  title      ▂▅▇ track  󰥔 Sun 27 Sep 14:32  󰖐 26°     tray hw io 󰂚 󰐥 │
#         └──────────────────────────────────────────────────────────────────────┘
#   dock           ┌────────────────────────────────────────────────────┐
#                  │ 󰀻 󰕰 │ pinned apps │   running windows   │ capture │ ⇪ │
#                  └────────────────────────────────────────────────────┘
#
#   The top bar is status (read at a glance); the dock is action (launch,
#   switch, capture).
#
# Lifecycle
#   `waybar.service` from the HM systemd unit (Restart=on-failure, SIGUSR2
#   reload when the generated config/style change on rebuild) rather than
#   niri's spawn-at-startup, so a crash never leaves the session without a bar.
#
# Look
#   The window is fully transparent; the only painted surface is the rounded
#   translucent bar box. niri blurs the layer (see the `^waybar$` layer-rule
#   in niri/config.kdl, whose geometry-corner-radius matches `barRadius`), so
#   the bar reads as frosted glass over the wallpaper.
#
# Robustness
#   * Modules for hardware a host lacks (battery/backlight on the desktop, the
#     AMD GPU chip on the aarch64 machine, …) hide themselves.
#   * Transient-state modules (privacy, failed units, media, cava) only
#     appear while there is something to show.
#   * All helper binaries are store paths; see ./scripts.nix.
{
  pkgs,
  config,
  ...
}:
let
  colors = config.lib.stylix.colors;
  scripts = import ./scripts.nix { inherit pkgs; };

  # Must equal `geometry-corner-radius` of the waybar layer-rule in niri.
  barRadius = 16;

  # TUIs launched from the bar open as a centred floating window (niri
  # window-rule on this title).
  terminal = cmd: "ghostty --title=waybar-popup -e ${cmd}";
  btm = terminal "${pkgs.bottom}/bin/btm";

  # Coloured glyph: icons carry the module colour, values stay neutral.
  ic = base: glyph: "<span color='#${colors.${base}}'>${glyph}</span>";
  # Material Design glyphs overhang their advance width; a thin space keeps
  # them off the following text.
  gap = "  "; # U+2009 THIN SPACE + space
  dim = text: "<span color='#${colors.base04}'>${text}</span>";

  # Pinned dock apps. `match` is an app-id regex: clicking focuses the newest
  # matching window, or launches `exec` when none is open. Middle-click
  # always opens a new instance.
  pinned = [
    { id = "terminal"; name = "Ghostty"; glyph = "󰊠"; color = "base0D"; match = "ghostty"; exec = "ghostty"; }
    { id = "brave"; name = "Brave"; glyph = "󰖟"; color = "base09"; match = "^brave"; exec = "brave"; }
    { id = "firefox"; name = "Firefox"; glyph = "󰈹"; color = "base08"; match = "^firefox"; exec = "firefox"; }
    { id = "files"; name = "Files"; glyph = "󰉋"; color = "base0A"; match = "nautilus"; exec = "nautilus --new-window"; }
    { id = "code"; name = "VS Code"; glyph = "󰨞"; color = "base0C"; match = "^code"; exec = "code"; }
    { id = "discord"; name = "Discord"; glyph = "󰙯"; color = "base0E"; match = "discord"; exec = "discord"; }
  ];

  pinnedModules = builtins.listToAttrs (
    map (app: {
      name = "custom/app-${app.id}";
      value = {
        format = ic app.color app.glyph;
        tooltip-format = "<b>${app.name}</b>\n\n${dim "Click  focus or open · Middle  new window"}";
        on-click = "${scripts.focusOrLaunch} '${app.match}' ${app.exec}";
        on-click-middle = "niri msg action spawn -- ${app.exec}";
      };
    }) pinned
  );

  # Native GTK popover for the power button (waybar `menu` feature).
  powerMenu = pkgs.writeText "waybar-power-menu.xml" ''
    <?xml version="1.0" encoding="UTF-8"?>
    <interface>
      <object class="GtkMenu" id="menu">
        <child><object class="GtkMenuItem" id="lock"><property name="label">󰌾   Lock</property></object></child>
        <child><object class="GtkMenuItem" id="suspend"><property name="label">󰒲   Suspend</property></object></child>
        <child><object class="GtkSeparatorMenuItem"/></child>
        <child><object class="GtkMenuItem" id="logout"><property name="label">󰍃   Log out</property></object></child>
        <child><object class="GtkMenuItem" id="reboot"><property name="label">󰜉   Restart</property></object></child>
        <child><object class="GtkMenuItem" id="firmware"><property name="label">󰍛   Restart to firmware</property></object></child>
        <child><object class="GtkSeparatorMenuItem"/></child>
        <child><object class="GtkMenuItem" id="shutdown"><property name="label">󰐥   Shut down</property></object></child>
      </object>
    </interface>
  '';
in
{
  stylix.targets.waybar = {
    enable = true;
    # Keep only stylix' palette/font injection; its base.css would add
    # workspace underlines and module backgrounds that fight ./style.nix.
    addCss = false;
  };

  programs.waybar = {
    enable = true;
    style = import ./style.nix { inherit colors barRadius; };

    systemd.enable = true;
    systemd.targets = [ "graphical-session.target" ];

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 40;
      spacing = 0;
      # 20px side margins line up with niri's `gaps 20`.
      margin-top = 10;
      margin-left = 20;
      margin-right = 20;

      modules-left = [
        "custom/logo"
        "niri/workspaces"
        "niri/window"
      ];

      modules-center = [
        "cava"
        "mpris"
        "clock"
        "custom/weather"
      ];

      modules-right = [
        "privacy"
        "systemd-failed-units"
        "tray"
        "group/hardware"
        "group/audio"
        "group/connectivity"
        "backlight"
        "battery"
        "custom/notifications"
        "custom/power"
      ];

      # ── Left ──────────────────────────────────────────────────────────────

      "custom/logo" = {
        format = "󱄅";
        tooltip-format = "<b>NixOS</b>\n\n${dim "Click  launcher · Right  overview"}";
        on-click = "rofi -show drun";
        on-click-right = "niri msg action toggle-overview";
      };

      "niri/workspaces" = {
        format = "{value}";
        on-click = "activate";
        on-scroll-up = "niri msg action focus-workspace-up";
        on-scroll-down = "niri msg action focus-workspace-down";
        smooth-scrolling-threshold = 1;
      };

      "niri/window" = {
        format = "{title}";
        icon = true;
        icon-size = 18;
        max-length = 56;
        separate-outputs = true;
        rewrite = {
          "(.*) [—-] Mozilla Firefox" = "$1";
          "(.*) - Visual Studio Code" = "$1";
          "(.*) [—-] Obsidian.*" = "$1";
          "(.*) - Zed" = "$1";
        };
      };

      # ── Centre ────────────────────────────────────────────────────────────

      # Built-in libcava visualiser; hides itself after 3 s of silence.
      cava = {
        method = "pipewire";
        source = "auto";
        framerate = 30;
        bars = 10;
        autosens = 1;
        stereo = false;
        lower_cutoff_freq = 50;
        higher_cutoff_freq = 10000;
        noise_reduction = 0.77;
        sleep_timer = 3;
        hide_on_silence = true;
        input_delay = 1;
        bar_delimiter = 0;
        format-icons = [
          "▁"
          "▂"
          "▃"
          "▄"
          "▅"
          "▆"
          "▇"
          "█"
        ];
        on-click = "playerctl play-pause";
      };

      mpris = {
        format = "${ic "base0B" "{player_icon}"}${gap}{dynamic}";
        format-paused = "${ic "base04" "{status_icon}"}${gap}${dim "{dynamic}"}";
        format-stopped = "";
        dynamic-order = [
          "title"
          "artist"
        ];
        dynamic-separator = " · ";
        dynamic-len = 42;
        dynamic-importance-order = [
          "title"
          "artist"
        ];
        player-icons = {
          default = "󰝚";
          firefox = "󰈹";
          brave = "󰖟";
          chromium = "󰊯";
          spotify = "󰓇";
          mpv = "󰐊";
        };
        status-icons = {
          paused = "󰏤";
          stopped = "󰓛";
        };
        tooltip-format = "<b>{title}</b>\n{artist}\n${dim "{album}"}\n\n${dim "{player} · {status}  {length}"}\n\n${dim "Click  play/pause · Right  next · Middle  previous"}";
        on-click = "playerctl play-pause";
        on-click-right = "playerctl next";
        on-click-middle = "playerctl previous";
      };

      clock = {
        interval = 1;
        # The markup lives inside the chrono spec so a single `{:…}` renders
        # both the dimmed date and the bold time.
        format = "${ic "base0D" "󰥔"}${gap}<span color='#${colors.base04}'>{:%a %d %b</span>  <b>%H:%M</b>}";
        format-alt = "${ic "base0D" "󰥔"}${gap}<span color='#${colors.base04}'>{:%A, %d %B %Y</span>  <b>%H:%M:%S</b>}";
        tooltip-format = "<tt>{calendar}</tt>";
        calendar = {
          mode = "month";
          mode-mon-col = 3;
          weeks-pos = "left";
          on-scroll = 1;
          format = {
            months = "<span color='#${colors.base0D}'><b>{}</b></span>";
            days = "<span color='#${colors.base05}'>{}</span>";
            weeks = "<span color='#${colors.base03}'>{:%V}</span>";
            weekdays = "<span color='#${colors.base0A}'><b>{}</b></span>";
            today = "<span color='#${colors.base00}' background='#${colors.base0D}'><b> {} </b></span>";
          };
        };
        actions = {
          on-click-right = "mode";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
          on-click-middle = "shift_reset";
        };
      };

      "custom/weather" = {
        exec = "${scripts.weather}";
        return-type = "json";
        restart-interval = 30;
        format = "{text}";
        on-click = terminal "sh -c '${pkgs.curl}/bin/curl -s \"https://wttr.in/?F&lang=en\"; read -r _'";
        on-click-right = "${pkgs.procps}/bin/pkill -USR1 -f '[-]waybar-weather$'";
      };

      # ── Right ─────────────────────────────────────────────────────────────

      # Only visible while the screen is shared or the mic is being recorded.
      privacy = {
        icon-size = 16;
        icon-spacing = 6;
        transition-duration = 250;
        modules = [
          { type = "screenshare"; }
          { type = "audio-in"; }
        ];
      };

      "systemd-failed-units" = {
        hide-on-ok = true;
        format = "󰀦 {nr_failed}";
        system = true;
        user = true;
        tooltip-format = "<b>Degraded</b>\nSystem  {nr_failed_system} failed\nUser    {nr_failed_user} failed\n\n${dim "Click  inspect"}";
        on-click = terminal "sh -c 'systemctl --failed; echo; systemctl --user --failed; read -r _'";
      };

      tray = {
        icon-size = 16;
        spacing = 10;
        show-passive-items = true;
      };

      "group/hardware" = {
        orientation = "horizontal";
        modules = [
          "cpu"
          "memory"
          "custom/cpu-temp"
          "custom/gpu"
          "disk"
        ];
      };

      cpu = {
        interval = 2;
        format = "${ic "base0D" "󰻠"}${gap}{usage:>2}%";
        states = {
          warning = 75;
          critical = 90;
        };
        tooltip-format = "<b>CPU</b>\n\nUsage\t{usage}%\nLoad\t{load}\nClock\t{avg_frequency} GHz avg · {max_frequency} GHz max";
        on-click = btm;
      };

      memory = {
        interval = 3;
        format = "${ic "base0E" "󰍛"}${gap}{percentage:>2}%";
        states = {
          warning = 80;
          critical = 92;
        };
        tooltip-format = "<b>Memory</b>\n\nRAM\t{used:0.1f} / {total:0.1f} GiB ({percentage}%)\nSwap\t{swapUsed:0.1f} / {swapTotal:0.1f} GiB ({swapPercentage}%)";
        on-click = btm;
      };

      "custom/cpu-temp" = {
        exec = "${scripts.cpuTemperature}";
        return-type = "json";
        interval = 3;
        format = "${ic "base0C" "{icon}"}${gap}{text}";
        format-icons = [
          "󱃃"
          "󰔏"
          "󱃂"
          "󰸁"
        ];
        on-click = btm;
      };

      "custom/gpu" = {
        exec = "${scripts.amdGpu}";
        return-type = "json";
        interval = 2;
        format = "${ic "base09" "󰢮"}${gap}{text}";
        on-click = terminal "nvtop";
      };

      disk = {
        interval = 60;
        path = "/";
        format = "${ic "base0A" "󰋊"}${gap}{percentage_used}%";
        states = {
          warning = 85;
          critical = 95;
        };
        tooltip-format = "<b>Disk</b>  {path}\n\nUsed\t{used} / {total} ({percentage_used}%)\nFree\t{free}";
        on-click = "nautilus /";
      };

      "group/audio" = {
        orientation = "horizontal";
        modules = [
          "wireplumber"
          "wireplumber#source"
        ];
      };

      wireplumber = {
        format = "${ic "base0B" "{icon}"}${gap}{volume:>2}%";
        format-muted = "${ic "base08" "󰝟"}${gap}${dim "mute"}";
        format-icons = [
          "󰕿"
          "󰖀"
          "󰕾"
        ];
        max-volume = 150;
        scroll-step = 5;
        states = {
          loud = 101;
        };
        tooltip-format = "<b>Output</b>\n{node_name}\n\nVolume\t{volume}%\n\n${dim "Click  mute · Right  mixer · Scroll  volume"}";
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        on-click-right = "pavucontrol -t 3";
      };

      "wireplumber#source" = {
        node-type = "Audio/Source";
        format = "${ic "base0E" "󰍬"}";
        format-muted = "${ic "base08" "󰍭"}";
        scroll-step = 5;
        tooltip-format = "<b>Input</b>\n{node_name}\n\nVolume\t{volume}%\n\n${dim "Click  mute · Right  mixer · Scroll  gain"}";
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        on-click-right = "pavucontrol -t 4";
      };

      "group/connectivity" = {
        orientation = "horizontal";
        modules = [
          "network"
          "bluetooth"
        ];
      };

      network = {
        interval = 3;
        format-ethernet = "${ic "base0C" "󰈀"}";
        format-wifi = "${ic "base0C" "{icon}"}";
        format-linked = "${ic "base0A" "󰈀"}${gap}${dim "no ip"}";
        format-disconnected = "${ic "base08" "󰤮"}";
        format-disabled = "${ic "base03" "󰤮"}";
        format-icons = [
          "󰤟"
          "󰤢"
          "󰤥"
          "󰤨"
        ];
        format-alt = "${ic "base0C" "󰇚"}${gap}{bandwidthDownBytes} ${ic "base0E" "󰕒"}${gap}{bandwidthUpBytes}";
        tooltip-format-ethernet = "<b>Ethernet</b>  {ifname}\n\nAddress\t{ipaddr}/{cidr}\nGateway\t{gwaddr}\nTraffic\t󰇚 {bandwidthDownBytes}  󰕒 {bandwidthUpBytes}\n\n${dim "Click  throughput · Right  connections"}";
        tooltip-format-wifi = "<b>{essid}</b>  {signalStrength}% · {frequency} GHz\n\nAddress\t{ipaddr}/{cidr}\nGateway\t{gwaddr}\nTraffic\t󰇚 {bandwidthDownBytes}  󰕒 {bandwidthUpBytes}\n\n${dim "Click  throughput · Right  connections"}";
        tooltip-format-disconnected = "<b>Offline</b>\n\n${dim "Right  connections"}";
        on-click-right = terminal "nmtui";
      };

      bluetooth = {
        format = "${ic "base0D" "󰂯"}";
        format-disabled = "";
        format-no-controller = "";
        format-off = "${ic "base03" "󰂲"}";
        format-connected = "${ic "base0D" "󰂱"}${gap}{num_connections}";
        format-connected-battery = "${ic "base0D" "󰂱"}${gap}{device_battery_percentage}%";
        tooltip-format = "<b>Bluetooth</b>  {controller_alias}\n{status}\n\n${dim "Click  manager"}";
        tooltip-format-connected = "<b>Bluetooth</b>  {controller_alias}\n\n{device_enumerate}\n\n${dim "Click  manager"}";
        tooltip-format-enumerate-connected = "󰥰  {device_alias}";
        tooltip-format-enumerate-connected-battery = "󰥰  {device_alias}\t{device_battery_percentage}%";
        on-click = "blueman-manager";
      };

      # Laptop-only modules: both hide on machines without the hardware (not
      # grouped, an all-hidden group would still paint an empty island).
      backlight = {
        format = "${ic "base0A" "{icon}"}${gap}{percent}%";
        format-icons = [
          "󰃞"
          "󰃟"
          "󰃠"
        ];
        tooltip-format = "Brightness {percent}%";
        on-scroll-up = "brightnessctl -q set 5%+";
        on-scroll-down = "brightnessctl -q set 5%-";
      };

      battery = {
        interval = 30;
        states = {
          warning = 25;
          critical = 12;
        };
        format = "${ic "base0B" "{icon}"}${gap}{capacity}%";
        format-charging = "${ic "base0B" "󰂄"}${gap}{capacity}%";
        format-plugged = "${ic "base0B" "󰚥"}${gap}{capacity}%";
        format-full = "${ic "base0B" "󰁹"}${gap}full";
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
        tooltip-format = "<b>Battery</b>  {capacity}%\n\n{timeTo}\nPower\t{power:.1f} W\nHealth\t{health}%\nCycles\t{cycles}";
        events = {
          on-discharging-warning = "notify-send -u normal -a Waybar -i battery-caution 'Battery low' 'Below 25% — plug in soon.'";
          on-discharging-critical = "notify-send -u critical -a Waybar -i battery-empty 'Battery critical' 'Below 12% — plug in now.'";
        };
      };

      "custom/notifications" = {
        exec = "${scripts.notifications}";
        return-type = "json";
        interval = 10;
        signal = 8;
        format = "{icon}";
        format-icons = {
          on = "󰂚";
          dnd = "󰂛";
        };
        on-click = "${scripts.toggleDnd}";
        on-click-right = "makoctl restore";
        on-click-middle = "makoctl dismiss --all";
      };

      "custom/power" = {
        format = "󰐥";
        tooltip-format = "<b>Power</b>\n\nClick  menu\nRight  rofi power menu";
        menu = "on-click";
        menu-file = "${powerMenu}";
        menu-actions = {
          lock = "loginctl lock-session";
          suspend = "systemctl suspend";
          logout = "niri msg action quit --skip-confirmation";
          reboot = "systemctl reboot";
          firmware = "systemctl reboot --firmware-setup";
          shutdown = "systemctl poweroff";
        };
        on-click-right = "rofi -show power-menu -modi power-menu:rofi-power-menu";
      };
    };

    # ── Dock (bottom) ─────────────────────────────────────────────────────

    settings.dock = pinnedModules // {
      name = "dock";
      layer = "top";
      position = "bottom";
      height = 50;
      spacing = 0;
      margin-bottom = 10;
      margin-left = 20;
      margin-right = 20;

      modules-left = [
        "custom/apps"
        "custom/overview"
        "group/pinned"
      ];

      modules-center = [ "wlr/taskbar" ];

      modules-right = [
        "group/capture"
        "keyboard-state"
        "custom/hotkeys"
      ];

      "custom/apps" = {
        format = "󰀻";
        tooltip-format = "<b>Applications</b>\n\n${dim "Click  launcher · Right  run command"}";
        on-click = "rofi -show drun";
        on-click-right = "rofi -show run";
      };

      "custom/overview" = {
        format = "󰕰";
        tooltip-format = "<b>Overview</b>\n\n${dim "Click  toggle · Scroll  switch column"}";
        on-click = "niri msg action toggle-overview";
        on-scroll-up = "niri msg action focus-column-left";
        on-scroll-down = "niri msg action focus-column-right";
      };

      "group/pinned" = {
        orientation = "horizontal";
        modules = map (app: "custom/app-${app.id}") pinned;
      };

      "wlr/taskbar" = {
        format = "{icon}";
        icon-size = 24;
        markup = true;
        sort-by-app-id = false;
        tooltip-format = "<b>{title}</b>\n${dim "{app_id}"}\n\n${dim "Click  focus · Middle  close · Right  maximize"}";
        on-click = "activate";
        on-click-middle = "close";
        on-click-right = "maximize";
        ignore-list = [ "waybar-popup" ];
        app_ids-mapping = {
          "brave-browser" = "brave-browser";
          "com.mitchellh.ghostty" = "com.mitchellh.ghostty";
        };
      };

      "custom/recorder" = {
        exec = "${scripts.recorderStatus}";
        return-type = "json";
        interval = 1;
        signal = 9;
        format = "{icon}{text}";
        format-icons = {
          idle = "󰑊";
          recording = "󰑊${gap}";
        };
        on-click = "${scripts.recorder} region";
        on-click-right = "${scripts.recorder} screen";
        on-click-middle = "${scripts.recorder} audio";
      };

      "group/capture" = {
        orientation = "horizontal";
        modules = [
          "custom/recorder"
          "custom/screenshot"
          "custom/color-picker"
          "custom/clipboard"
        ];
      };

      "custom/screenshot" = {
        format = "󰹑";
        tooltip-format = "<b>Screenshot</b>\nSaved and copied to clipboard\n\n${dim "Click  region · Right  screen · Middle  window"}";
        on-click = "niri msg action screenshot";
        on-click-right = "niri msg action screenshot-screen";
        on-click-middle = "niri msg action screenshot-window";
      };

      "custom/color-picker" = {
        format = "󰈊";
        tooltip-format = "<b>Colour picker</b>\n\n${dim "Click  pick and copy hex"}";
        on-click = "${scripts.pickColor}";
      };

      "custom/clipboard" = {
        format = "󰅌";
        tooltip-format = "<b>Clipboard</b>\n\n${dim "Click  history · Right  clear"}";
        on-click = "${scripts.clipboard}";
        on-click-right = "${scripts.clearClipboard}";
      };

      keyboard-state = {
        numlock = true;
        capslock = true;
        format = {
          numlock = "{icon}${gap}num";
          capslock = "{icon}${gap}caps";
        };
        format-icons = {
          locked = "󰌾";
          unlocked = "󰿆";
        };
      };

      "custom/hotkeys" = {
        format = "󰌌";
        tooltip-format = "<b>Keyboard shortcuts</b>\n\n${dim "Click  show niri hotkeys"}";
        on-click = "niri msg action show-hotkey-overlay";
      };
    };
  };
}
