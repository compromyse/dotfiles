{ lib, inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ] ++ (map (path: ../../modules/${path}) [
    "core/global.nix"
    "ssh.nix"
    "compromyse.nix"
    "git/user.nix"
    "git/cgit.nix"
  ]);

  networking.hostName = "oxo";

  boot.loader.grub = {
    enable = true;
    forceInstall = true;
    device = "/dev/sda";
  };

  programs.fuse.userAllowOther = true;
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      git = import ./git-home.nix;
      compromyse = import ./home.nix
    };
  };
}
