{
  description = "Flake that holds the configs for all of Arepita's NixOS machines";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # I need the latest version of WiVRn, which is sometimes not in nixpkgs unstable
    wivrn.url = "github:wivrn/wivrn";

  };

  outputs =
    { nixpkgs, ... }@inputs:
    {

      nixosConfigurations.kimba = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          inputs.home-manager.nixosModules.home-manager
          ./hosts/kimba
          ./common
        ];
      };

    };
}
