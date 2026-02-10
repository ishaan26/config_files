{pkgs, ...}: {
  # System packages
  environment.systemPackages = with pkgs; [
    fish
    git
    wget
    gnupg
    pinentry_mac
    gnumake
  ];

  # Homebrew integration (for GUI apps not in nixpkgs)
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };

    # Add this to see more output
    global.brewfile = true;

    # Mac App Store apps (requires you to be signed in to the App Store)
    masApps = {
      "Microsoft Excel" = 462058435;
      "Microsoft Word" = 462054704;
      "Microsoft PowerPoint" = 462062816;
      "Onedrive" = 823766827;

      "Dropover" = 1355679052;
      "WhatsApp Messenger" = 310633997;

      "Xcode" = 497799835;
    };

    # GUI Apps
    casks = [
      "firefox"
      "brave-browser"
      "bitwarden"
      "discord"
      "imageoptim"
      "github"
      "logi-options+"
      "zed"
      "google-drive"
      "macs-fan-control"
      "stats"
      "libreoffice"
      "steam"
      "blender"
      "thaw"
    ];

    # CLI tools not in nixpkgs
    brews = [
      "imageoptim-cli"
    ];
  };

  # Fonts (system-wide)
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.iosevka-term
    nerd-fonts.space-mono
  ];
}
