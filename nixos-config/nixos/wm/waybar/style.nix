{ colors }:
let
  c = colors;
in ''
  /* ============================================================
     WAYBAR PREMIUM THEME - Stylix Dynamic (GTK Variables)
     Defined from Nix interpolation
     ============================================================ */
  
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
    background: linear-gradient(
      135deg,
      alpha(@base00, 0.85) 0%,
      alpha(@base01, 0.75) 100%
    );
    border-radius: 16px;
    border: 1px solid alpha(@base04, 0.1);
    box-shadow: 
      0 8px 32px rgba(0, 0, 0, 0.4),
      0 0 0 1px alpha(@base05, 0.05) inset,
      0 2px 4px rgba(0, 0, 0, 0.2);
    margin: 0 4px;
  }

  /* Secondary bar styling */
  window#waybar.bottom > box {
    border-radius: 12px;
    background: linear-gradient(
      180deg,
      alpha(@base00, 0.8) 0%,
      alpha(@base01, 0.7) 100%
    );
  }

  /* ============================================================
     TOOLTIPS
     ============================================================ */

  tooltip {
    background: linear-gradient(
      135deg,
      alpha(@base00, 0.95) 0%,
      alpha(@base01, 0.9) 100%
    );
    border: 1px solid alpha(@base0D, 0.3);
    border-radius: 12px;
    box-shadow: 
      0 8px 24px rgba(0, 0, 0, 0.5),
      0 0 20px alpha(@base0D, 0.1);
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
    background: linear-gradient(
      135deg,
      alpha(@base0D, 0.15) 0%,
      alpha(@base0D, 0.05) 100%
    );
    border-radius: 12px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }

  #custom-logo:hover {
    background: linear-gradient(
      135deg,
      alpha(@base0D, 0.25) 0%,
      alpha(@base0D, 0.1) 100%
    );
    text-shadow: 0 0 12px alpha(@base0D, 0.5);
  }

  /* ============================================================
     CLOCK MODULE
     ============================================================ */

  #clock {
    color: @base08;
    font-weight: 600;
    padding: 4px 16px;
    margin: 4px 2px;
    background: linear-gradient(
      135deg,
      alpha(@base08, 0.15) 0%,
      alpha(@base08, 0.05) 100%
    );
    border-radius: 10px;
    border-left: 3px solid @base08;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }

  #clock:hover {
    background: linear-gradient(
      135deg,
      alpha(@base08, 0.25) 0%,
      alpha(@base08, 0.1) 100%
    );
    text-shadow: 0 0 8px alpha(@base08, 0.4);
  }

  /* ============================================================
     WORKSPACES
     ============================================================ */

  #workspaces {
    background: linear-gradient(
      180deg,
      alpha(@base01, 0.6) 0%,
      alpha(@base02, 0.4) 100%
    );
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
    background: linear-gradient(
      135deg,
      alpha(@base0D, 0.2) 0%,
      alpha(@base0D, 0.1) 100%
    );
    color: @base0D;
    box-shadow: 0 0 12px alpha(@base0D, 0.2);
  }

  #workspaces button.active,
  #workspaces button.focused {
    background: linear-gradient(
      135deg,
      alpha(@base0D, 0.35) 0%,
      alpha(@base0D, 0.2) 100%
    );
    color: @base07;
    font-weight: bold;
    box-shadow: 
      0 0 16px alpha(@base0D, 0.3),
      0 0 0 1px alpha(@base0D, 0.3) inset;
    text-shadow: 0 0 8px alpha(@base0D, 0.5);
  }

  #workspaces button.empty {
    color: @base03;
  }

  #workspaces button.urgent {
    background: linear-gradient(
      135deg,
      alpha(@base08, 0.4) 0%,
      alpha(@base08, 0.2) 100%
    );
    color: @base08;
    animation: pulse-urgent 1.5s ease-in-out infinite;
  }

  @keyframes pulse-urgent {
    0% { box-shadow: 0 0 8px alpha(@base08, 0.3); }
    50% { box-shadow: 0 0 20px alpha(@base08, 0.6); }
    100% { box-shadow: 0 0 8px alpha(@base08, 0.3); }
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
    background: linear-gradient(
      135deg,
      alpha(@base0B, 0.12) 0%,
      alpha(@base0B, 0.04) 100%
    );
    border-radius: 10px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }

  #mpris:hover {
    background: linear-gradient(
      135deg,
      alpha(@base0B, 0.22) 0%,
      alpha(@base0B, 0.08) 100%
    );
  }

  #mpris.paused {
    color: @base03;
    font-style: italic;
  }

  #mpris.playing {
    color: @base0B;
    text-shadow: 0 0 8px alpha(@base0B, 0.3);
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
    background: linear-gradient(
      135deg,
      alpha(@base0C, 0.2) 0%,
      alpha(@base0C, 0.08) 100%
    );
    text-shadow: 0 0 8px alpha(@base0C, 0.4);
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
    background: linear-gradient(
      135deg,
      alpha(@base02, 0.5) 0%,
      alpha(@base03, 0.3) 100%
    );
    border-radius: 10px;
  }

  #tray > .passive {
    -gtk-icon-effect: dim;
  }

  #tray > .needs-attention {
    -gtk-icon-effect: highlight;
    background: linear-gradient(
      135deg,
      alpha(@base08, 0.3) 0%,
      alpha(@base08, 0.15) 100%
    );
    border-radius: 6px;
  }

  #tray menu {
    background: alpha(@base00, 0.95);
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
    background: linear-gradient(
      135deg,
      alpha(@base0D, 0.1) 0%,
      transparent 100%
    );
  }

  #cpu:hover {
    background: linear-gradient(
      135deg,
      alpha(@base0D, 0.2) 0%,
      alpha(@base0D, 0.08) 100%
    );
  }

  #cpu.warning {
    color: @base0A;
  }

  #cpu.critical {
    color: @base08;
    animation: pulse-critical 1s ease-in-out infinite;
  }

  /* Memory */
  #memory {
    color: @base0E;
    background: linear-gradient(
      135deg,
      alpha(@base0E, 0.1) 0%,
      transparent 100%
    );
  }

  #memory:hover {
    background: linear-gradient(
      135deg,
      alpha(@base0E, 0.2) 0%,
      alpha(@base0E, 0.08) 100%
    );
  }

  /* Disk */
  #disk {
    color: @base0A;
    background: linear-gradient(
      135deg,
      alpha(@base0A, 0.1) 0%,
      transparent 100%
    );
  }

  #disk:hover {
    background: linear-gradient(
      135deg,
      alpha(@base0A, 0.2) 0%,
      alpha(@base0A, 0.08) 100%
    );
  }

  /* Temperature */
  #temperature {
    color: @base0C;
    background: linear-gradient(
      135deg,
      alpha(@base0C, 0.1) 0%,
      transparent 100%
    );
  }

  #temperature:hover {
    background: linear-gradient(
      135deg,
      alpha(@base0C, 0.2) 0%,
      alpha(@base0C, 0.08) 100%
    );
  }

  #temperature.critical {
    color: @base08;
    animation: pulse-critical 0.5s ease-in-out infinite alternate;
  }

  @keyframes pulse-critical {
    0% { 
      background-color: alpha(@base08, 0.2); 
    }
    100% { 
      background-color: alpha(@base08, 0.4); 
    }
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
    background: linear-gradient(
      135deg,
      alpha(@base0B, 0.1) 0%,
      transparent 100%
    );
  }

  #network:hover {
    background: linear-gradient(
      135deg,
      alpha(@base0B, 0.2) 0%,
      alpha(@base0B, 0.08) 100%
    );
  }

  #network.disconnected {
    color: @base08;
    background: linear-gradient(
      135deg,
      alpha(@base08, 0.1) 0%,
      transparent 100%
    );
  }

  #network.linked {
    color: @base0A;
  }

  /* Bluetooth */
  #bluetooth {
    color: @base0D;
    background: linear-gradient(
      135deg,
      alpha(@base0D, 0.1) 0%,
      transparent 100%
    );
  }

  #bluetooth:hover {
    background: linear-gradient(
      135deg,
      alpha(@base0D, 0.2) 0%,
      alpha(@base0D, 0.08) 100%
    );
  }

  #bluetooth.connected {
    color: @base0C;
    text-shadow: 0 0 6px alpha(@base0C, 0.3);
  }

  #bluetooth.off,
  #bluetooth.disabled {
    color: @base03;
  }

  /* PulseAudio */
  #pulseaudio {
    color: @base09;
    background: linear-gradient(
      135deg,
      alpha(@base09, 0.1) 0%,
      transparent 100%
    );
  }

  #pulseaudio:hover {
    background: linear-gradient(
      135deg,
      alpha(@base09, 0.2) 0%,
      alpha(@base09, 0.08) 100%
    );
  }

  #pulseaudio.muted {
    color: @base03;
    text-decoration: line-through;
  }

  #pulseaudio.bluetooth {
    color: @base0D;
  }

  /* Microphone */
  #pulseaudio.microphone {
    color: @base0E;
    background: linear-gradient(
      135deg,
      alpha(@base0E, 0.1) 0%,
      transparent 100%
    );
  }

  #pulseaudio.source-muted {
    color: @base03;
  }

  /* Backlight */
  #backlight {
    color: @base0A;
    background: linear-gradient(
      135deg,
      alpha(@base0A, 0.1) 0%,
      transparent 100%
    );
  }

  #backlight:hover {
    background: linear-gradient(
      135deg,
      alpha(@base0A, 0.2) 0%,
      alpha(@base0A, 0.08) 100%
    );
  }

  /* Battery */
  #battery {
    color: @base0B;
    background: linear-gradient(
      135deg,
      alpha(@base0B, 0.12) 0%,
      transparent 100%
    );
  }

  #battery:hover {
    background: linear-gradient(
      135deg,
      alpha(@base0B, 0.22) 0%,
      alpha(@base0B, 0.08) 100%
    );
  }

  #battery.charging,
  #battery.plugged {
    color: @base0C;
    background: linear-gradient(
      135deg,
      alpha(@base0C, 0.12) 0%,
      transparent 100%
    );
    animation: charging-glow 2s ease-in-out infinite;
  }

  @keyframes charging-glow {
    0% { text-shadow: 0 0 4px alpha(@base0C, 0.3); }
    50% { text-shadow: 0 0 12px alpha(@base0C, 0.6); }
    100% { text-shadow: 0 0 4px alpha(@base0C, 0.3); }
  }

  #battery.full {
    color: @base0B;
    text-shadow: 0 0 6px alpha(@base0B, 0.4);
  }

  #battery.good {
    color: @base0B;
  }

  #battery.warning:not(.charging) {
    color: @base0A;
    background: linear-gradient(
      135deg,
      alpha(@base0A, 0.15) 0%,
      transparent 100%
    );
  }

  #battery.critical:not(.charging) {
    color: @base08;
    background: linear-gradient(
      135deg,
      alpha(@base08, 0.15) 0%,
      transparent 100%
    );
    animation: battery-critical 0.8s ease-in-out infinite alternate;
  }

  @keyframes battery-critical {
    0% {
      background-color: alpha(@base08, 0.15);
      text-shadow: 0 0 4px alpha(@base08, 0.3);
    }
    100% {
      background-color: alpha(@base08, 0.35);
      text-shadow: 0 0 12px alpha(@base08, 0.6);
    }
  }

  /* ============================================================
     POWER BUTTON
     ============================================================ */

  #custom-power {
    color: @base08;
    font-size: 16px;
    padding: 4px 14px 4px 12px;
    margin: 4px 6px 4px 2px;
    background: linear-gradient(
      135deg,
      alpha(@base08, 0.12) 0%,
      alpha(@base08, 0.04) 100%
    );
    border-radius: 10px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }

  #custom-power:hover {
    background: linear-gradient(
      135deg,
      alpha(@base08, 0.3) 0%,
      alpha(@base08, 0.15) 100%
    );
    text-shadow: 0 0 12px alpha(@base08, 0.5);
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
    background: alpha(@base0D, 0.15);
  }

  #taskbar button.active {
    background: alpha(@base0D, 0.25);
    box-shadow: 0 0 8px alpha(@base0D, 0.2);
  }

  /* Clipboard */
  #custom-clipboard {
    color: @base0E;
    padding: 2px 12px;
    font-size: 15px;
    transition: all 0.2s ease;
  }

  #custom-clipboard:hover {
    text-shadow: 0 0 8px alpha(@base0E, 0.4);
  }

  /* Screenshot */
  #custom-screenshot {
    color: @base0C;
    padding: 2px 12px;
    font-size: 15px;
    transition: all 0.2s ease;
  }

  #custom-screenshot:hover {
    text-shadow: 0 0 8px alpha(@base0C, 0.4);
  }

  /* Color Picker */
  #custom-colorpicker {
    color: @base0A;
    padding: 2px 12px;
    font-size: 15px;
    transition: all 0.2s ease;
  }

  #custom-colorpicker:hover {
    text-shadow: 0 0 8px alpha(@base0A, 0.4);
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
