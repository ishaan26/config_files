{
  description = "Ishaan's NixOS configuration";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, home-manager, ... }:

  let
    system = "x86_64-linux";
    
  in {
    nixosConfigurations.Paimon = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ishaan = import ./home.nix;
        }
      ];
    };
  };
}
