{ lib, inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ] ++ (map (path: ../../modules/${path}) [
    "core/global.nix"
    "ssh.nix"
    "git/compromyse.nix"
    "git/cgit.nix"
  ]);

  networking.hostName = "git";

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

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
