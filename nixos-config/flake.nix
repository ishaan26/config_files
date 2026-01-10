{
  description = "Ishaan's NixOS and nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # nix-darwin for macOS
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:nix-community/stylix";

    awww.url = "git+https://codeberg.org/LGFae/awww";
  };

  outputs = { nixpkgs, nix-darwin, home-manager, stylix, awww, ... }:

    let
      # Function to create a NixOS configuration (Linux)
      mkNixosSystem = { hostName, system }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix

            stylix.nixosModules.stylix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit awww; };
              home-manager.users.ishaan = { imports = [ ./home.nix ]; };

              # Backup existing config files instead of failing
              home-manager.backupFileExtension = "backup";

              # Set hostname
              networking.hostName = hostName;
            }
          ];
        };

      # Function to create a Darwin configuration (macOS)
      mkDarwinSystem = { hostName, system }:
        nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./darwin-configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ishaan = { imports = [ ./home-darwin.nix ]; };
              # Backup existing config files instead of failing
              home-manager.backupFileExtension = "backup";
              # Set hostname for Darwin
              networking.hostName = hostName;
              networking.computerName = hostName;
              system.defaults.smb.NetBIOSName = hostName;
            }
          ];
        };

    in {
      # NixOS configurations (Linux)
      nixosConfigurations = {
        # Existing x86_64-linux machine
        Paimon = mkNixosSystem {
          hostName = "Paimon";
          system = "x86_64-linux";
        };

        # aarch64-linux machine (ARM Linux)
        Vetala = mkNixosSystem {
          hostName = "Vetala";
          system = "aarch64-linux";
        };
      };

      # Darwin configurations (macOS)
      darwinConfigurations = {
        # Apple Silicon Mac (M1/M2/M3)
        Noir = mkDarwinSystem {
          hostName = "Noir";
          system = "aarch64-darwin";
        };
        # Intel Mac (if needed)
        # IntelMac = mkDarwinSystem {
        #   hostName = "IntelMac";
        #   system = "x86_64-darwin";
        # };
      };
    };
}
