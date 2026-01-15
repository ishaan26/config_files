{
  description = "Ishaan's NixOS and nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # neovim
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Themes
    stylix.url = "github:nix-community/stylix";

    # Wallpapers
    awww.url = "git+https://codeberg.org/LGFae/awww";

    # Zellij Plugin
    zjstatus.url = "github:dj95/zjstatus";
  };

  outputs = {
    nixpkgs,
    nix-darwin,
    home-manager,
    nvf,
    stylix,
    awww,
    zjstatus,
    ...
  }: let
    # Function to create a NixOS configuration (Linux)
    mkNixosSystem = {
      hostName,
      system,
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/configuration.nix
          stylix.nixosModules.stylix
          {networking.hostName = hostName;}
        ];
      };

    # Function to create a Darwin configuration (macOS)
    mkDarwinSystem = {
      hostName,
      system,
    }:
      nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./darwin/configuration.nix
          stylix.darwinModules.stylix
          {
            networking.hostName = hostName;
            networking.computerName = hostName;
            system.defaults.smb.NetBIOSName = hostName;
          }
        ];
      };

    # Function to create a standalone home-manager configuration
    mkHomeConfig = {
      system,
      homeFile,
      extraModules ? [],
    }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            (final: prev: {
              zjstatus = zjstatus.packages.${prev.system}.default;
            })
          ];
        };

        extraSpecialArgs = {inherit awww;};

        modules =
          [
            homeFile
            nvf.homeManagerModules.default
            stylix.homeModules.stylix
            ./common/stylix.nix
          ]
          ++ extraModules;
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
