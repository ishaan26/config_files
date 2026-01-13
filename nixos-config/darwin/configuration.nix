{ pkgs, ... }: {
  imports = [ ../common/stylix.nix ];

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.primaryUser = "ishaan";

  users.users.ishaan = {
    description = "Ishaan Goel";
    shell = pkgs.fish;
    home = "/Users/ishaan";
  };

  # sudo via fingerprint
  security.pam.services.sudo_local.touchIdAuth = true;

  # Enable fish system-wide
  programs.fish.enable = true;

  # GPG agent
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # macOS system settings
  system = {
    defaults = {
      dock = {
        autohide = false;
        show-recents = false;
        minimize-to-application = true;
        enable-spring-load-actions-on-all-items = true;
        persistent-apps = [
          "/System/Applications/Apps.app"
          "/Applications/Bitwarden.app"
          "/System/Cryptexes/App/System/Applications/Safari.app"
          "/Applications/Brave Browser.app"
          "/Applications/Firefox.app"
          "/Applications/WhatsApp.app"
          "/System/Applications/Mail.app"
          "/Applications/Microsoft Word.app"
          "/Applications/Microsoft Excel.app"
          "/System/Applications/Notes.app"
          "/System/Applications/App Store.app"
          "/Users/ishaan/Applications/Home Manager Apps/Alacritty.app"
          "/System/Applications/System Settings.app"
        ];
      };
      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "list";
      };
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleIconAppearanceTheme = "RegularDark";
        KeyRepeat = 2;
        InitialKeyRepeat = 20;
        ApplePressAndHoldEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        AppleShowAllFiles = true;
        AppleShowScrollBars = "Automatic";
        NSDocumentSaveNewDocumentsToCloud = false;
        NSNavPanelExpandedStateForSaveMode2 = true;
      };
      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = false;
      };
      controlcenter = {
        BatteryShowPercentage = true;
        Bluetooth = true;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      swapLeftCtrlAndFn = true;
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
      "Onedrive" = 823766827;

      "Dropover" = 1355679052;
      "WhatsApp Messenger" = 310633997;
    };

    # GUI Apps
    casks = [
      "firefox"
      "brave-browser"
      "bitwarden"
    ];

    # CLI tools not in nixpkgs
    brews = [
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
