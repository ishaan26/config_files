{
  description = "Ishaan's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    awww.url = "git+https://codeberg.org/LGFae/awww";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { nixpkgs, home-manager, awww, catppuccin, ... }:

    let
      # Function to create a NixOS configuration
      mkSystem = { hostName, system }: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit awww; };
            home-manager.users.ishaan = imports [
              ./home.nix
              catppuccin.homeModules.catppuccin
            ];

            # Backup existing config files instead of failing
            home-manager.backupFileExtension = "backup";


            # Set hostname
            networking.hostName = hostName;

          }
        ];
      };

    in
    {
      nixosConfigurations = {
        # Existing x86_64-linux machine
        Paimon = mkSystem {
          hostName = "Paimon";
          system = "x86_64-linux";
        };

        # New aarch64-linux machine (ARM)
        # You can rename "Sumeru" to whatever you want your ARM machine to be called
        Sumeru = mkSystem {
          hostName = "Sumeru";
          system = "aarch64-linux";
        };
      };
    };
}
