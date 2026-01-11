{ pkgs, ... }: {
  imports = [ ./stylix.nix ];

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.primaryUser = "ishaan";

  users.users.ishaan = {
    description = "Ishaan Goel";
    shell = pkgs.fish;
    home = "/Users/ishaan";
  };

  # Enable fish system-wide
  programs.fish.enable = true;

  # GPG agent
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # macOS system settings
  system.defaults = {
    dock = {
      autohide = false;
      show-recents = false;
      minimize-to-application = true;
      enable-spring-load-actions-on-all-items = true;
      persistent-apps = [
        "/Applications/Safari.app"
        "/Applications/Brave Browser.app"
        "/Applications/WhatsApp.app"
        "/System/Applications/Mail.app"
        "/Applications/Microsoft Word.app"
        "/System/Applications/Notes.app"
        "/Users/ishaan/Applications/Home Manager Apps/kitty.app"
        "/System/Applications/App Store.app"
      ];
    };
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2;
      InitialKeyRepeat = 20;
      ApplePressAndHoldEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = false;
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    fish
    git
    neovim
    wget
    gnupg
    pinentry_mac
    gnumake
    unzip
  ];

  # Homebrew integration (for GUI apps not in nixpkgs)
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };

    # Mac App Store apps (requires you to be signed in to the App Store)
    masApps = {
      "Microsoft Excel" = 462058435;
      "Microsoft Word" = 462054704;
      "Microsoft PowerPoint" = 462062816;

      "Dropover" = 1355679052;
      "WhatsApp Messenger" = 310633997;
    };

    # GUI Apps
    casks = [
      "firefox"
      "brave-browser"
      "bitwarden"
      # "discord"
    ];

    # CLI tools not in nixpkgs
    brews = [
      "fontconfig"
      "topgrade"
    ];

  };

  # Set shell
  environment.shells = [ pkgs.fish ];

  # Fonts (system-wide)
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.iosevka-term
  ];

  # Used for backwards compatibility
  system.stateVersion = 6;
}
