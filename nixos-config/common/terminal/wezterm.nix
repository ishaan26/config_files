{pkgs, ...}: {
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = wezterm.config_builder()

      -- Shell integration
      config.default_prog = { '${pkgs.fish}/bin/fish' }

      -- Appearance
      config.window_decorations = "INTEGRATED_BUTTONS|RESIZE|MACOS_FORCE_ENABLE_SHADOW"
      config.window_background_opacity = 0.85
      config.macos_window_background_blur = 30
      config.window_padding = {
        left = 40,
        right = 40,
        top = 40,
        bottom = 40,
      }

      config.font_size = 16.0

      -- Tab Bar
      config.use_fancy_tab_bar = false
      config.tab_bar_at_bottom = true
      config.hide_tab_bar_if_only_one_tab = true

      -- Mouse
      config.mouse_bindings = {
        {
          event = { Up = { streak = 1, button = 'Left' } },
          mods = 'NONE',
          action = wezterm.action.CompleteSelection 'ClipboardAndPrimarySelection',
        },
      }

      return config
    '';
  };
}
