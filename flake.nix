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

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Disko
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Impermanence
    impermanence.url = "github:nix-community/impermanence";

    # GRUB2 themes
    grub2-themes.url = "github:vinceliuice/grub2-themes";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # nixos-rebuild --flake .#machine
    nixosConfigurations = {

      x = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          inputs.disko.nixosModules.default

          ./machines/x/configuration.nix

          inputs.home-manager.nixosModules.default
          inputs.impermanence.nixosModules.impermanence
          inputs.grub2-themes.nixosModules.default
        ];
      };

    };
  };
}
