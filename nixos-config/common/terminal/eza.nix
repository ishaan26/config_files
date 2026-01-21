{...}: {
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    icons = "always";
    git = true;

    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };

  # Set the icon spacing environment variable
  home.sessionVariables = {
    EZA_ICON_SPACING = "2"; # Adjust this number to your preference
  };
}
