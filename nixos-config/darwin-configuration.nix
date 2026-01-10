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
      autohide = true;
      show-recents = false;
      minimize-to-application = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      ApplePressAndHoldEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
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
    casks = [
      # Uncomment/add apps you want from Homebrew
      # "brave-browser"
      # "bitwarden"
      # "discord"
    ];
    brews = [
      # CLI tools not in nixpkgs
    ];
  };

  # Set shell
  environment.shells = [ pkgs.fish ];

  # Fonts (system-wide)
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  # Used for backwards compatibility
  system.stateVersion = 6;
}
