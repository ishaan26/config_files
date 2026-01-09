{ pkgs, ... }:

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

    # NOTE: The following settings are controlled by stylix
    # theme = ./theme.rasi;
  };

  # Power menu script
  home.packages = with pkgs; [ rofi-power-menu ];
}
