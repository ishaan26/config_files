{ pkgs, config, lib, ... }:

let inherit (config.lib.formats.rasi) mkLiteral;
in {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    terminal = "${pkgs.ghostty}/bin/ghostty";

    extraConfig = {
      modi = "drun,run,window,filebrowser";
      show-icons = true;
      icon-theme = "Papirus-Dark";
      display-drun = "Apps";
      display-run = "Run";
      display-window = "Window";
      display-filebrowser = "Files";
      drun-display-format = "{name}";
      window-format = "{w} · {c} · {t}";

      # Interaction
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

    # Incredible Grid Layout
    theme = {
      "*" = { font = "${config.stylix.fonts.monospace.name} 12"; };

      window = {
        width = mkLiteral "45%";
      #  height = mkLiteral "55%"; # Dynamic height? Fixed looks cleaner for grid
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        border = mkLiteral "2px solid";
        border-radius = mkLiteral "16px";
        padding = mkLiteral "20px";
      };

      mainbox = {
        children = map (x: mkLiteral x) [ "inputbar" "message" "listview" ];
        spacing = mkLiteral "20px";
        padding = mkLiteral "20px";
      };

      inputbar = {
        children = map (x: mkLiteral x) [ "prompt" "entry" ];
        border-radius = mkLiteral "12px";
        padding = mkLiteral "14px";
        spacing = mkLiteral "12px";
      };

      entry = {
        placeholder = "Search...";
        cursor = mkLiteral "text";
        placeholder-color = mkLiteral "inherit";
      };

      message = {
        border-radius = mkLiteral "8px";
        padding = mkLiteral "12px";
      };

      listview = {
        columns = 6;
        lines = 4;
        spacing = mkLiteral "15px";
        cycle = false;
        dynamic = true;
        scrollbar = false;
        layout = mkLiteral "vertical";
        fixed-height = false;
        fixed-columns = true;
      };

      element = {
        orientation = mkLiteral "vertical";
        padding = mkLiteral "25px 10px";
        spacing = mkLiteral "10px";
        border-radius = mkLiteral "12px";
        cursor = mkLiteral "pointer";
        background-color = mkLiteral "transparent"; 
      };

      "element normal.normal" = {
        background-color = lib.mkForce "transparent";
      };

      "element alternate.normal" = {
        background-color = lib.mkForce "transparent";
      };

      "element selected.normal" = {
        border = mkLiteral "2px solid";
        # Stylix provides background/text colors
      };

      element-icon = {
        size = mkLiteral "64px";
        horizontal-align = mkLiteral "0.5";
        cursor = mkLiteral "inherit";
      };

      element-text = {
        horizontal-align = mkLiteral "0.5";
        vertical-align = mkLiteral "0.5";
        font =
          "${config.stylix.fonts.monospace.name} Medium 11"; # Slightly smaller but cleaner for grid labels
        cursor = mkLiteral "inherit";
      };

      # Hide mode switcher for cleaner look, or keep it?
      # User had it, but "Uninspiring" often calls for minimalism.
      # Left it out of mainbox children above for maximum cleanliness.

      error-message = {
        border = mkLiteral "2px solid";
        border-radius = mkLiteral "12px";
        padding = mkLiteral "20px";
      };
    };
  };

  # Power menu script
  home.packages = with pkgs; [ rofi-power-menu ];
}
