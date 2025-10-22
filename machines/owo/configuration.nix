{ lib, inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ] ++ (map (path: ../../modules/${path}) [
    "core/global.nix"
    "ssh.nix"
    "compromyse.nix"
    "timer-clean-backups.nix"
  ]);

  networking.hostName = "owo";

  boot.loader.grub = {
    enable = true;
    forceInstall = true;
    device = "/dev/sda";
  };

  networking.firewall = {
    enable = lib.mkForce true;
    allowedTCPPorts = [ 22 ];
  };

  programs.fuse.userAllowOther = true;
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      compromyse = import ./home.nix;
    };
  };
}
