{ pkgs, config, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    terminal = "${pkgs.ghostty}/bin/ghostty";

    extraConfig = {
      modi = "drun,run,window,filebrowser";
      show-icons = true;
      icon-theme = "Papirus-Dark";
      display-drun = " Apps";
      display-run = " Run";
      display-window = " Windows";
      display-filebrowser = " Files";
      drun-display-format = "{name}";
      window-format = "{w} · {c} · {t}";

      # Layout
      sidebar-mode = true;
      hover-select = true;
      me-select-entry = "";
      me-accept-entry = "MousePrimary";

      # Matching
      matching = "fuzzy";
      sort = true;
      sorting-method = "fzf";

      # Misc
      disable-history = false;
      scroll-method = 0;
      normalize-match = true;
    };
    # Custom spacing/layout (Stylix handles colors)
    theme = {
      "*" = {
        spacing = 0;
        width = 800;
      };
      window = {
        border = "2px solid";
        border-radius = 16;
        padding = 32;
        location = "center";
        anchor = "center";
      };
      mainbox = {
        children = map (x: "${x}") [ "inputbar" "message" "listview" "mode-switcher" ];
        spacing = 12;
      };
      inputbar = {
        border-radius = 12;
        padding = "12px 16px";
        spacing = 12;
        children = map (x: "${x}") [ "prompt" "entry" ];
        font = "${config.stylix.fonts.monospace.name} 16";
      };
      entry = {
        placeholder = "Search...";
        font = "${config.stylix.fonts.monospace.name} 16";
      };
      message = {
        border-radius = 8;
        padding = "8px 12px";
        font = "${config.stylix.fonts.monospace.name} 16";
      };
      listview = {
        lines = 8;
        columns = 1;
        spacing = 6;
        fixed-height = true;
        scrollbar = false;
      };
      element = {
        border-radius = 4;
        padding = "16px 32px";
        spacing = 16;
      };
      "element selected.normal" = {
        border = "1px solid";
      };
      element-icon = {
        size = 32;
      };
      element-text = {
        vertical-align = "0.5";
        font-weight = "bold";
        font = "${config.stylix.fonts.monospace.name} 16";
      };
      mode-switcher = {
        border-radius = 10;
        padding = 4;
        spacing = 4;
      };
      button = {
        border-radius = 8;
        padding = "8px 16px";
      };
      scrollbar = {
        handle-width = 4;
        border-radius = 4;
        margin = "0 4px";
      };
      error-message = {
        border = "2px solid";
        border-radius = 12;
        padding = 16;
      };
    };
  };

  # Power menu script
  home.packages = with pkgs; [ rofi-power-menu ];
}
