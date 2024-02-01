{
  description = "Nix Configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixpkgs.overlays = [ import ./overlays/dwl.nix ];
    # nixos-rebuild --flake .#machine
    nixosConfigurations = {
      z = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./machines/z/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
