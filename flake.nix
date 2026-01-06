{
  description = "Flake that holds the configs for all of Arepita's NixOS machines";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # I need the latest version of WiVRn, which is sometimes not in nixpkgs unstable
    wivrn.url = "github:wivrn/wivrn";

  };

  outputs =
    { nixpkgs, ... }@inputs:
    {

      nixosConfigurations.kimba = nixpkgs.lib.nixosSystem {
        specialArgs = inputs;
        modules = [
          ./common
          ./hosts/kimba
          inputs.home-manager.nixosModules.home-manager
        ];
      };

    };
}
