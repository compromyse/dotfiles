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
    "git/timer-update-timestamps.nix"
    "git/timer-backup.nix"
    "web/user.nix"
    "headscale.nix"
  ] ++ [
    ./www.nix
  ]);

  networking.hostName = "oxo";

  boot.loader.grub = {
    enable = true;
    forceInstall = true;
    device = "/dev/sda";
  };

  networking.firewall = {
    enable = lib.mkForce true;
    allowedTCPPorts = [ 80 443 22 ];
  };

  programs.fuse.userAllowOther = true;
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      git = import ./git-home.nix;
      compromyse = import ./home.nix;
    };
  };
}
