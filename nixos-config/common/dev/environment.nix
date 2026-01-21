{config, ...}: {
  # to use flakes for development
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;

    config = {
      # Optionally whitelist specific directories
      whitelist = {
        prefix = [
          "~/Documents/Github/" # Auto-allow all projects in this folder
        ];
      };
    };
  };

  home.sessionVariables = {
    # Rust
    CARGO_HOME = "$HOME/.cargo";
    CARGO_TARGET_DIR = "$HOME/.cargo/target-dump";
    RUSTUP_HOME = "$HOME/.rustup";

    # Python
    PYTHONPATH = "${config.home.homeDirectory}/.local/lib/python3.13/site-packages:$PYTHONPATH";
  };
}
