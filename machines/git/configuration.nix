{ lib, inputs, pkgs, ... }:

let
  drive = "/dev/vda";
in {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default

    (import ../../disko.nix { device = drive; })

  ] ++ (map (path: ../../modules/${path}) [
    "core/global.nix"
    "core/impermanence.nix"
    "git/compromyse.nix"
    "git/cgit.nix"
  ]);

  networking.hostName = "git";

  programs.fuse.userAllowOther = true;
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      "compromyse" = import ./home.nix;
    };
  };
}
