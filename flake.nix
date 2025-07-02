{
  description = "NixOS flake for midnadimple's miscellaneous machines";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.jealousy = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./jealousy/configuration.nix
        inputs.disko.nixosModules.disko
        ./jealousy/disko-config.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.abdulmujeeb = ./abdulmujeeb/home.nix;
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
  };
}
