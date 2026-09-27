# Waybar stylesheet (GTK3 CSS).
#
# `colors` is the stylix base16 palette (hex without '#'); `barRadius` must
# match the niri layer-rule so the compositor blur has the same shape as the
# painted bar.
#
# Structure
#   window#waybar          fully transparent layer surface
#   └ box (the bar)        translucent glass, the only painted full-width box
#     ├ islands            workspaces, clock and module groups sit on a
#     │                    slightly lighter rounded plate
#     └ chips              every module: neutral text, coloured icon (colour
#                          comes from pango spans in the formats), hover plate
#
# State classes only change `color`/animation: custom modules get state
# classes on the label, and backgrounds there would stack with the island.
{ colors, barRadius }:
let
  r = toString barRadius;
  islandRadius = toString (barRadius - 5);
  chipRadius = toString (barRadius - 7);
  ease = "cubic-bezier(0.25, 0.1, 0.25, 1)";
in
''
  @define-color base00 #${colors.base00};
  @define-color base01 #${colors.base01};
  @define-color base02 #${colors.base02};
  @define-color base03 #${colors.base03};
  @define-color base04 #${colors.base04};
  @define-color base05 #${colors.base05};
  @define-color base06 #${colors.base06};
  @define-color base07 #${colors.base07};
  @define-color base08 #${colors.base08};
  @define-color base09 #${colors.base09};
  @define-color base0A #${colors.base0A};
  @define-color base0B #${colors.base0B};
  @define-color base0C #${colors.base0C};
  @define-color base0D #${colors.base0D};
  @define-color base0E #${colors.base0E};
  @define-color base0F #${colors.base0F};

  @define-color glass    alpha(@base00, 0.58);
  @define-color island   alpha(@base01, 0.55);
  @define-color hover    alpha(@base05, 0.08);
  @define-color hairline alpha(@base05, 0.08);

  * {
    font-family: "ZedMono Nerd Font", "JetBrainsMono Nerd Font", monospace;
    font-size: 14px;
    font-weight: 500;
    min-height: 0;
    border: none;
    border-radius: 0;
    margin: 0;
    padding: 0;
    box-shadow: none;
    text-shadow: none;
  }

  /* ── Bar ─────────────────────────────────────────────────────────────── */

  window#waybar {
    background: transparent;
    color: @base05;
  }

  window#waybar > box {
    background-color: @glass;
    border: 1px solid @hairline;
    border-radius: ${r}px;
    padding: 0 4px;
    box-shadow: inset 0 1px alpha(@base07, 0.04);
    transition: background-color 400ms ${ease};
  }

  /* Nothing focused on this output: let more of the wallpaper through. */
  window#waybar.empty > box {
    background-color: alpha(@base00, 0.42);
  }

  /* ── Shared chip geometry ────────────────────────────────────────────── */

  #custom-logo,
  #window,
  #cava,
  #mpris,
  #clock,
  #custom-weather,
  #privacy,
  #systemd-failed-units,
  #tray,
  #backlight,
  #battery,
  #custom-notifications,
  #custom-power {
    padding: 0 10px;
    margin: 5px 2px;
    border-radius: ${islandRadius}px;
    transition: background-color 200ms ${ease}, color 200ms ${ease};
  }

  #custom-logo:hover,
  #mpris:hover,
  #clock:hover,
  #custom-weather:hover,
  #backlight:hover,
  #battery:hover,
  #custom-notifications:hover {
    background-color: @hover;
  }

  /* Islands: plates that group related chips. */
  #workspaces,
  #clock,
  #hardware,
  #audio,
  #connectivity {
    background-color: @island;
    border-radius: ${islandRadius}px;
    margin: 5px 3px;
  }

  #hardware,
  #audio,
  #connectivity {
    padding: 0 2px;
  }

  #hardware > widget > *,
  #audio > widget > *,
  #connectivity > widget > * {
    padding: 0 8px;
    margin: 3px 0;
    border-radius: ${chipRadius}px;
    transition: background-color 200ms ${ease}, color 200ms ${ease};
  }

  #hardware > widget > *:hover,
  #audio > widget > *:hover,
  #connectivity > widget > *:hover {
    background-color: @hover;
  }

  /* ── Left ────────────────────────────────────────────────────────────── */

  #custom-logo {
    color: @base0D;
    font-size: 19px;
    padding: 0 13px 0 11px;
    margin-left: 4px;
  }

  #custom-logo:hover {
    color: @base0C;
    background-color: alpha(@base0D, 0.14);
  }

  #workspaces {
    padding: 0 3px;
  }

  #workspaces button {
    all: unset;
    color: @base04;
    font-weight: 700;
    font-size: 13px;
    min-width: 22px;
    padding: 0 4px;
    margin: 4px 1px;
    border-radius: ${chipRadius}px;
    transition: min-width 300ms ${ease}, background-color 250ms ${ease},
                color 250ms ${ease};
  }

  #workspaces button label {
    color: inherit;
  }

  #workspaces button.empty {
    color: @base03;
  }

  #workspaces button.active {
    color: @base06;
  }

  #workspaces button:hover {
    background-color: @hover;
    color: @base07;
  }

  #workspaces button.focused {
    min-width: 40px;
    color: @base00;
    background-color: @base0D;
    box-shadow: 0 0 10px alpha(@base0D, 0.35);
  }

  #workspaces button.urgent {
    color: @base00;
    background-color: @base08;
    animation: pulse 1.2s ease-in-out infinite alternate;
  }

  #window {
    color: @base06;
    padding: 0 12px;
    margin-left: 4px;
  }

  #window image {
    margin-right: 6px;
  }

  /* ── Centre ──────────────────────────────────────────────────────────── */

  #cava {
    color: @base0B;
    padding: 0 4px;
    margin-right: 0;
  }

  #mpris {
    color: @base06;
    margin-right: 6px;
  }

  #clock {
    color: @base06;
    padding: 0 14px;
  }

  #custom-weather {
    color: @base06;
    margin-left: 6px;
  }

  #custom-weather.stale {
    color: @base04;
  }

  /* ── Right ───────────────────────────────────────────────────────────── */

  #privacy {
    background-color: alpha(@base08, 0.16);
    padding: 0 8px;
    animation: pulse 1.6s ease-in-out infinite alternate;
  }

  #privacy-item {
    color: @base08;
    padding: 0 2px;
  }

  #systemd-failed-units {
    color: @base00;
    background-color: @base08;
    font-weight: 700;
  }

  #tray {
    padding: 0 8px;
  }

  #tray > .passive {
    -gtk-icon-effect: dim;
  }

  #tray > .needs-attention {
    -gtk-icon-effect: highlight;
    background-color: alpha(@base08, 0.2);
    border-radius: ${chipRadius}px;
  }

  /* Hardware (native modules get states; custom scripts emit classes). */
  #cpu.warning,
  #memory.warning,
  #disk.warning,
  #custom-cpu-temp.warning,
  #custom-gpu.warning {
    color: @base0A;
  }

  #cpu.critical,
  #memory.critical,
  #disk.critical,
  #custom-cpu-temp.critical,
  #custom-gpu.critical {
    color: @base08;
    animation: pulse 0.9s ease-in-out infinite alternate;
  }

  /* Audio */
  #wireplumber.muted {
    color: @base04;
  }

  #wireplumber.loud {
    color: @base09;
  }

  #wireplumber.source {
    padding: 0 9px 0 6px;
  }

  /* Connectivity */
  #network.disconnected,
  #network.disabled {
    color: @base08;
  }

  #network.linked {
    color: @base0A;
  }

  #bluetooth.off {
    color: @base03;
  }

  /* Laptop */
  #battery.charging,
  #battery.plugged {
    color: @base0B;
  }

  #battery.warning:not(.charging) {
    color: @base0A;
  }

  #battery.critical:not(.charging) {
    color: @base08;
    animation: pulse 0.8s ease-in-out infinite alternate;
  }

  #custom-notifications {
    color: @base06;
    padding: 0 11px;
  }

  #custom-notifications.dnd {
    color: @base08;
    background-color: alpha(@base08, 0.12);
  }

  #custom-power {
    color: @base08;
    padding: 0 13px 0 12px;
    margin-right: 4px;
  }

  #custom-power:hover {
    color: @base00;
    background-color: @base08;
  }

  /* ── Dock (bottom bar) ───────────────────────────────────────────────── */

  window#waybar.dock > box {
    padding: 0 5px;
  }

  #custom-apps,
  #custom-overview,
  #custom-hotkeys {
    font-size: 18px;
    padding: 0 11px;
    margin: 6px 2px;
    border-radius: ${islandRadius}px;
    transition: background-color 200ms ${ease}, color 200ms ${ease};
  }

  #custom-apps {
    color: @base0D;
    margin-left: 3px;
  }

  #custom-overview {
    color: @base0E;
  }

  #custom-hotkeys {
    color: @base04;
    margin-right: 3px;
  }

  #custom-apps:hover,
  #custom-overview:hover,
  #custom-hotkeys:hover {
    background-color: @hover;
  }

  #custom-apps:hover {
    background-color: alpha(@base0D, 0.16);
  }

  #custom-hotkeys:hover {
    color: @base06;
  }

  /* Islands on the dock */
  #pinned,
  #capture,
  #taskbar,
  #keyboard-state {
    background-color: @island;
    border-radius: ${islandRadius}px;
    margin: 6px 3px;
    padding: 0 3px;
  }

  #pinned > widget > *,
  #capture > widget > * {
    font-size: 19px;
    padding: 0 10px;
    margin: 3px 0;
    border-radius: ${chipRadius}px;
    transition: background-color 200ms ${ease}, color 200ms ${ease};
  }

  #pinned > widget > *:hover,
  #capture > widget > *:hover {
    background-color: @hover;
  }

  #custom-screenshot { color: @base0C; }
  #custom-color-picker { color: @base0E; }
  #custom-clipboard { color: @base0A; }

  /* Running windows */
  #taskbar {
    padding: 0 4px;
  }

  #taskbar button {
    all: unset;
    padding: 0 9px;
    margin: 3px 1px;
    border-radius: ${chipRadius}px;
    transition: background-color 200ms ${ease}, box-shadow 200ms ${ease};
  }

  #taskbar button:hover {
    background-color: @hover;
  }

  /* Accent underline marks the focused window. */
  #taskbar button.active {
    background-color: alpha(@base0D, 0.16);
    box-shadow: inset 0 -2px @base0D;
  }

  #taskbar button.minimized {
    opacity: 0.45;
  }

  #taskbar.empty {
    background-color: transparent;
  }

  /* Screen recorder */
  #custom-recorder {
    color: @base08;
  }

  #custom-recorder.recording {
    color: @base00;
    background-color: @base08;
    font-size: 14px;
    font-weight: 700;
    animation: pulse 1s ease-in-out infinite alternate;
  }

  /* Lock keys: quiet when off, lit when on */
  #keyboard-state {
    padding: 0 5px;
  }

  #keyboard-state label {
    color: @base03;
    font-size: 12px;
    font-weight: 700;
    padding: 0 7px;
    margin: 4px 0;
    border-radius: ${chipRadius}px;
    transition: background-color 200ms ${ease}, color 200ms ${ease};
  }

  #keyboard-state label.locked {
    color: @base00;
    background-color: @base0A;
  }

  /* ── Tooltips & menus ────────────────────────────────────────────────── */

  tooltip {
    background-color: alpha(@base00, 0.96);
    border: 1px solid alpha(@base0D, 0.28);
    border-radius: ${islandRadius}px;
  }

  tooltip label {
    color: @base05;
    font-size: 13px;
    padding: 6px 6px;
  }

  menu {
    background-color: alpha(@base00, 0.97);
    border: 1px solid alpha(@base05, 0.1);
    border-radius: ${islandRadius}px;
    padding: 6px;
  }

  menu menuitem {
    color: @base05;
    padding: 7px 14px;
    border-radius: ${chipRadius}px;
    transition: background-color 150ms ${ease};
  }

  menu menuitem:hover {
    color: @base07;
    background-color: alpha(@base0D, 0.2);
  }

  menu menuitem:disabled {
    color: @base03;
  }

  menu separator {
    min-height: 1px;
    margin: 5px 8px;
    background-color: @hairline;
  }

  menu arrow {
    min-width: 12px;
    min-height: 12px;
    color: @base04;
  }

  /* ── Motion ──────────────────────────────────────────────────────────── */

  @keyframes pulse {
    from { opacity: 1; }
    to   { opacity: 0.55; }
  }
''
