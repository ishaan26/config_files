{ lib, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      size = lib.mkForce 18;
    };
    settings = {
      # Blur settings
      background_blur = 64; # 0-100, higher = more blur
      background_opacity = lib.mkForce "0.75"; # 0.0-1.0

      # Window configuration
      cursor_shape = "block";
      hide_window_decorations = "titlebar-only";
      remember_window_size = "no";
      initial_window_width = "180c";
      initial_window_height = "50c";
      dynamic_background_opacity = "yes";
      window_padding_width = 10;

      # Performance
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = "yes";

      # Cursor
      cursor_blink_interval = 0; # Disable blinking for better focus
      cursor_stop_blinking_after = 0;

      # Mouse
      mouse_hide_wait = 3.0;
      copy_on_select = "yes"; # Auto-copy selection to clipboard
      strip_trailing_spaces = "smart"; # Remove trailing spaces when copying

      # URL handling
      url_style = "curly";
      open_url_with = "default";
      detect_urls = "yes";

      # Bell
      enable_audio_bell = "no";
      visual_bell_duration = 0.0;

      # Tab bar
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{index}: {title}";

      # Scrollback
      scrollback_lines = 10000;
      scrollback_pager_history_size = 10; # MB

      # Window splits (if you use Kitty's native splits)
      enabled_layouts = "splits,stack";

      # Clipboard
      clipboard_control = "write-clipboard write-primary read-clipboard-ask read-primary-ask";

      # Shell integration
      shell_integration = "enabled";
    };

    keybindings = {
      # Opacity adjustments
      "cmd+shift+equal" = "set_background_opacity +0.05";
      "cmd+shift+minus" = "set_background_opacity -0.05";
      "cmd+shift+0" = "set_background_opacity default";

      # Tmux pane navigation
      "alt+h" = "send_text all \\x1b\\x68";
      "alt+l" = "send_text all \\x1b\\x6c";
      "alt+j" = "send_text all \\x1b\\x6a";
      "alt+k" = "send_text all \\x1b\\x6b";

      # Quick font size adjustments
      "cmd+equal" = "change_font_size all +1.0";
      "cmd+minus" = "change_font_size all -1.0";
      "cmd+0" = "change_font_size all 0";

      # Scrollback
      "cmd+shift+h" = "show_scrollback";

      # Clear screen and scrollback
      "cmd+k" = "clear_terminal scrollback active";

      # New window/tab
      "cmd+enter" = "new_window_with_cwd";
      "cmd+t" = "new_tab_with_cwd";
    };
  };
}
