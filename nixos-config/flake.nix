{
  description = "Ishaan's NixOS and nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Themes. Stylix is a module-only flake, so following our nixpkgs is safe.
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Wallpapers. Do NOT follow nixpkgs: awww builds from source and pins its
    # own nixpkgs + rust-overlay for a known-good build.
    awww.url = "git+https://codeberg.org/LGFae/awww";
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      stylix,
      awww,
      ...
    }:
    let
      # Function to create a NixOS configuration (Linux)
      mkNixosSystem =
        {
          hostName,
          system,
        }:
        nixpkgs.lib.nixosSystem {
          modules = [
            ./nixos/configuration.nix
            stylix.nixosModules.stylix
            {
              networking.hostName = hostName;
              nixpkgs.hostPlatform = system;
              nixpkgs.config.allowUnfree = true;
            }
          ];
        };

      # Function to create a Darwin configuration (macOS)
      mkDarwinSystem =
        {
          hostName,
          system,
        }:
        nix-darwin.lib.darwinSystem {
          modules = [
            ./darwin/configuration.nix
            stylix.darwinModules.stylix
            {
              networking.hostName = hostName;
              networking.computerName = hostName;
              system.defaults.smb.NetBIOSName = hostName;
              nixpkgs.hostPlatform = system;
              nixpkgs.config.allowUnfree = true;
            }
          ];
        };

      # Function to create a standalone home-manager configuration
      mkHomeConfig =
        {
          system,
          homeFile,
          extraModules ? [ ],
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          extraSpecialArgs = { inherit awww; };

          modules = [
            homeFile
            stylix.homeModules.stylix
            ./common/stylix.nix
          ]
          ++ extraModules;
        };
    in
    {
      # NixOS configurations (Linux)
      nixosConfigurations = {
        Paimon = mkNixosSystem {
          hostName = "Paimon";
          system = "x86_64-linux";
        };

        Vetala = mkNixosSystem {
          hostName = "Vetala";
          system = "aarch64-linux";
        };
      };

      # Darwin configurations (macOS)
      darwinConfigurations = {
        # Apple Silicon Mac
        Noir = mkDarwinSystem {
          hostName = "Noir";
          system = "aarch64-darwin";
        };

        # NOTE: An Intel Mac placeholder used to live here. nixpkgs unstable
        # (26.11) dropped x86_64-darwin support entirely; if an Intel Mac is
        # ever needed again, pin nixpkgs to "nixpkgs-26.05-darwin" for it.
      };

      # Add packages output for nh compatibility
      packages = {
        aarch64-darwin.Noir = self.darwinConfigurations.Noir.system;
        x86_64-linux.Paimon = self.nixosConfigurations.Paimon.config.system.build.toplevel;
        aarch64-linux.Vetala = self.nixosConfigurations.Vetala.config.system.build.toplevel;
      };

      # Standalone home-manager configurations
      homeConfigurations = {
        "ishaan@Paimon" = mkHomeConfig {
          system = "x86_64-linux";
          homeFile = ./nixos/home.nix;
        };
        "ishaan@Vetala" = mkHomeConfig {
          system = "aarch64-linux";
          homeFile = ./nixos/home.nix;
        };
        "ishaan@Noir" = mkHomeConfig {
          system = "aarch64-darwin";
          homeFile = ./darwin/home.nix;
        };
      };
    };
}
