{ colors }:
let
  c = colors;
in ''

  @define-color base00 #${c.base00};
  @define-color base01 #${c.base01};
  @define-color base02 #${c.base02};
  @define-color base03 #${c.base03};
  @define-color base04 #${c.base04};
  @define-color base05 #${c.base05};
  @define-color base06 #${c.base06};
  @define-color base07 #${c.base07};
  @define-color base08 #${c.base08};
  @define-color base09 #${c.base09};
  @define-color base0A #${c.base0A};
  @define-color base0B #${c.base0B};
  @define-color base0C #${c.base0C};
  @define-color base0D #${c.base0D};
  @define-color base0E #${c.base0E};
  @define-color base0F #${c.base0F};

  * {
    border: none;
    border-radius: 0;
    font-family: "ZedMono Nerd Font", "Symbols Nerd Font Mono", monospace;
    font-size: 14px;
    font-weight: 500;
    min-height: 0;
    margin: 0;
    padding: 0;
  }

  /* ============================================================
     MAIN BAR CONTAINER
     ============================================================ */

  window#waybar {
    background: transparent;
    color: @base05;
  }

  window#waybar > box {
    background-color: alpha(@base00, 0.9);
    border-radius: 16px;
    border: 1px solid alpha(@base04, 0.1);
    margin: 0 4px;
  }

  /* Secondary bar styling */
  window#waybar.bottom > box {
    border-radius: 12px;
    background-color: alpha(@base00, 0.9);
  }

  /* ============================================================
     TOOLTIPS
     ============================================================ */

  tooltip {
    background-color: @base00;
    border: 1px solid alpha(@base0D, 0.3);
    border-radius: 12px;
  }

  tooltip label {
    color: @base06;
    padding: 8px 12px;
    font-size: 13px;
  }

  /* ============================================================
     GLOBAL BUTTON RESET
     ============================================================ */

  button {
    box-shadow: none;
    border: none;
    border-radius: 0;
    background: transparent;
    min-width: 0;
    min-height: 0;
  }

  button:hover {
    background: transparent;
    box-shadow: none;
  }

  /* ============================================================
     LOGO MODULE
     ============================================================ */

  #custom-logo {
    font-size: 20px;
    color: @base0D;
    padding: 4px 14px 4px 16px;
    margin: 4px 0 4px 6px;
    background-color: alpha(@base0D, 0.1);
    border-radius: 12px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }

  #custom-logo:hover {
    background-color: alpha(@base0D, 0.2);
  }

  /* ============================================================
     CLOCK MODULE
     ============================================================ */

  #clock {
    color: @base08;
    font-weight: 600;
    padding: 4px 16px;
    margin: 4px 2px;
    background-color: alpha(@base08, 0.1);
    border-radius: 10px;
    border-left: 3px solid @base08;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }

  #clock:hover {
    background-color: alpha(@base08, 0.2);
  }

  /* ============================================================
     WORKSPACES
     ============================================================ */

  #workspaces {
    background-color: alpha(@base01, 0.4);
    border-radius: 14px;
    padding: 2px 6px;
    margin: 4px 8px;
    border: 1px solid alpha(@base04, 0.08);
  }

  #workspaces button {
    padding: 4px 12px;
    color: @base04;
    border-radius: 10px;
    margin: 2px;
    font-size: 16px;
    transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
    min-width: 32px;
    background: transparent;
  }

  #workspaces button:hover {
    background-color: alpha(@base0D, 0.1);
    color: @base0D;
  }

  #workspaces button.active,
  #workspaces button.focused {
    background-color: @base0D;
    color: @base00;
    font-weight: bold;
    box-shadow: inset 0 -3px transparent;
    text-shadow: none;
    border: none;
    border-bottom: none;
    background-image: none;
  }

  #workspaces button.empty {
    color: @base03;
  }

  #workspaces button.urgent {
    background-color: @base08;
    color: @base00;
    animation: pulse-urgent 1.5s ease-in-out infinite;
  }

  @keyframes pulse-urgent {
    0% { opacity: 1; }
    50% { opacity: 0.7; }
    100% { opacity: 1; }
  }

  /* ============================================================
     WINDOW TITLE
     ============================================================ */

  #window {
    color: @base04;
    padding: 4px 12px;
    margin: 4px 4px;
    font-weight: 500;
    font-style: italic;
    opacity: 0.9;
    transition: all 0.3s ease;
  }

  #window.empty {
    opacity: 0.5;
    font-style: normal;
  }

  /* ============================================================
     MPRIS / MEDIA PLAYER
     ============================================================ */

  #mpris {
    color: @base0B;
    padding: 4px 14px;
    margin: 4px 2px;
    background-color: alpha(@base0B, 0.1);
    border-radius: 10px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }

  #mpris:hover {
    background-color: alpha(@base0B, 0.2);
  }

  #mpris.paused {
    color: @base03;
    font-style: italic;
  }

  #mpris.playing {
    color: @base0B;
  }

  /* ============================================================
     SEPARATOR
     ============================================================ */

  #custom-separator {
    color: alpha(@base04, 0.15);
    padding: 0 4px;
    font-size: 12px;
  }

  /* ============================================================
     IDLE INHIBITOR (CAFFEINE)
     ============================================================ */

  #idle_inhibitor {
    color: @base03;
    padding: 4px 12px;
    margin: 4px 2px;
    font-size: 16px;
    border-radius: 10px;
    transition: all 0.3s ease;
  }

  #idle_inhibitor.activated {
    color: @base0C;
    background-color: alpha(@base0C, 0.1);
    animation: breathe 3s ease-in-out infinite;
  }

  @keyframes breathe {
    0% { opacity: 1; }
    50% { opacity: 0.7; }
    100% { opacity: 1; }
  }

  /* ============================================================
     SYSTEM TRAY
     ============================================================ */

  #tray {
    margin: 4px 4px;
    padding: 4px 12px;
    background-color: alpha(@base02, 0.4);
    border-radius: 10px;
  }

  #tray > .passive {
    -gtk-icon-effect: dim;
  }

  #tray > .needs-attention {
    -gtk-icon-effect: highlight;
    background-color: alpha(@base08, 0.2);
    border-radius: 6px;
  }

  #tray menu {
    background-color: @base00;
    border: 1px solid alpha(@base04, 0.1);
    border-radius: 8px;
  }

  /* ============================================================
     HARDWARE GROUP (CPU, Memory, Disk, Temperature)
     ============================================================ */

  #cpu,
  #memory,
  #disk,
  #temperature {
    padding: 4px 10px;
    margin: 4px 1px;
    border-radius: 8px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }

  /* CPU */
  #cpu {
    color: @base0D;
    background-color: alpha(@base0D, 0.1);
  }

  #cpu:hover {
    background-color: alpha(@base0D, 0.2);
  }

  #cpu.warning {
    color: @base0A;
  }

  #cpu.critical {
    color: @base08;
    background-color: alpha(@base08, 0.1);
    animation: pulse-critical 1s ease-in-out infinite;
  }

  /* Memory */
  #memory {
    color: @base0E;
    background-color: alpha(@base0E, 0.1);
  }

  #memory:hover {
    background-color: alpha(@base0E, 0.2);
  }

  /* Disk */
  #disk {
    color: @base0A;
    background-color: alpha(@base0A, 0.1);
  }

  #disk:hover {
    background-color: alpha(@base0A, 0.2);
  }

  /* Temperature */
  #temperature {
    color: @base0C;
    background-color: alpha(@base0C, 0.1);
  }

  #temperature:hover {
    background-color: alpha(@base0C, 0.2);
  }

  #temperature.critical {
    color: @base08;
    background-color: alpha(@base08, 0.1);
    animation: pulse-critical 0.5s ease-in-out infinite alternate;
  }

  @keyframes pulse-critical {
    0% { opacity: 1; }
    100% { opacity: 0.6; }
  }

  /* ============================================================
     SYSTEM GROUP (Network, Bluetooth, Audio, Backlight, Battery)
     ============================================================ */

  #network,
  #bluetooth,
  #pulseaudio,
  #backlight,
  #battery {
    padding: 4px 12px;
    margin: 4px 1px;
    border-radius: 8px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }

  /* Network */
  #network {
    color: @base0B;
    background-color: alpha(@base0B, 0.1);
  }

  #network:hover {
    background-color: alpha(@base0B, 0.2);
  }

  #network.disconnected {
    color: @base08;
    background-color: alpha(@base08, 0.1);
  }

  #network.linked {
    color: @base0A;
  }

  /* Bluetooth */
  #bluetooth {
    color: @base0D;
    background-color: alpha(@base0D, 0.1);
  }

  #bluetooth:hover {
    background-color: alpha(@base0D, 0.2);
  }

  #bluetooth.connected {
    color: @base0C;
    background-color: alpha(@base0C, 0.1);
  }

  #bluetooth.off,
  #bluetooth.disabled {
    color: @base03;
    background-color: transparent;
  }

  /* PulseAudio */
  #pulseaudio {
    color: @base09;
    background-color: alpha(@base09, 0.1);
  }

  #pulseaudio:hover {
    background-color: alpha(@base09, 0.2);
  }

  #pulseaudio.muted {
    color: @base03;
    text-decoration: line-through;
    background-color: transparent;
  }

  #pulseaudio.bluetooth {
    color: @base0D;
  }

  /* Microphone */
  #pulseaudio.microphone {
    color: @base0E;
    background-color: alpha(@base0E, 0.1);
  }

  #pulseaudio.source-muted {
    color: @base03;
    background-color: transparent;
  }

  /* Backlight */
  #backlight {
    color: @base0A;
    background-color: alpha(@base0A, 0.1);
  }

  #backlight:hover {
    background-color: alpha(@base0A, 0.2);
  }

  /* Battery */
  #battery {
    color: @base0B;
    background-color: alpha(@base0B, 0.1);
  }

  #battery:hover {
    background-color: alpha(@base0B, 0.2);
  }

  #battery.charging,
  #battery.plugged {
    color: @base0C;
    background-color: alpha(@base0C, 0.1);
    animation: charging-glow 2s ease-in-out infinite;
  }

  @keyframes charging-glow {
    0% { opacity: 1; }
    50% { opacity: 0.7; }
    100% { opacity: 1; }
  }

  #battery.full {
    color: @base0B;
  }

  #battery.good {
    color: @base0B;
  }

  #battery.warning:not(.charging) {
    color: @base0A;
    background-color: alpha(@base0A, 0.1);
  }

  #battery.critical:not(.charging) {
    color: @base08;
    background-color: alpha(@base08, 0.1);
    animation: battery-critical 0.8s ease-in-out infinite alternate;
  }

  @keyframes battery-critical {
    0% { opacity: 1; }
    100% { opacity: 0.5; }
  }

  /* ============================================================
     POWER BUTTON
     ============================================================ */

  #custom-power {
    color: @base08;
    font-size: 16px;
    padding: 4px 14px 4px 12px;
    margin: 4px 6px 4px 2px;
    background-color: alpha(@base08, 0.1);
    border-radius: 10px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }

  #custom-power:hover {
    background-color: alpha(@base08, 0.2);
  }

  /* ============================================================
     SECONDARY BAR MODULES
     ============================================================ */

  /* Weather */
  #custom-weather {
    color: @base0D;
    padding: 2px 14px;
    margin: 2px 4px;
    font-size: 13px;
    background-color: alpha(@base0D, 0.1);
    border-radius: 8px;
  }

  /* Spotify */
  #custom-spotify {
    color: @base0B;
    padding: 2px 12px;
    margin: 2px 4px;
    font-size: 13px;
    font-style: italic;
  }

  /* Taskbar */
  #taskbar {
    background: transparent;
    padding: 0 8px;
  }

  #taskbar button {
    padding: 4px 8px;
    margin: 2px;
    border-radius: 8px;
    transition: all 0.2s ease;
  }

  #taskbar button:hover {
    background-color: alpha(@base0D, 0.15);
  }

  #taskbar button.active {
    background-color: alpha(@base0D, 0.25);
  }

  /* Clipboard */
  #custom-clipboard {
    color: @base0E;
    padding: 2px 12px;
    font-size: 15px;
    transition: all 0.2s ease;
  }

  #custom-clipboard:hover {
    background-color: alpha(@base0E, 0.1);
    border-radius: 6px;
  }

  /* Screenshot */
  #custom-screenshot {
    color: @base0C;
    padding: 2px 12px;
    font-size: 15px;
    transition: all 0.2s ease;
  }

  #custom-screenshot:hover {
    background-color: alpha(@base0C, 0.1);
    border-radius: 6px;
  }

  /* Color Picker */
  #custom-colorpicker {
    color: @base0A;
    padding: 2px 12px;
    font-size: 15px;
    transition: all 0.2s ease;
  }

  #custom-colorpicker:hover {
    background-color: alpha(@base0A, 0.1);
    border-radius: 6px;
  }

  /* Keyboard State */
  #keyboard-state {
    padding: 2px 12px;
    margin: 2px 4px;
  }

  #keyboard-state label {
    color: @base03;
    font-size: 13px;
  }

  #keyboard-state label.locked {
    color: @base08;
  }
''
