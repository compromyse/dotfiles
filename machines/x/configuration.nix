{ lib, inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ] ++ (map (path: ../../modules/${path}) [
    "global.nix"
    "compromyse.nix"
    "login.nix"
    "wm.nix"
    "fonts.nix"
    "bluetooth.nix"
    "audio.nix"
    "virtualization.nix"
    "nvidia.nix"
  ]);

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.extraModprobeConfig = "options kvm_intel nested=1";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  hardware.opengl.enable = true;

  fileSystems."/data" = {
    device = "/dev/sda";
    fsType = "ext4";
  };

  networking.hostName = "x";

  home-manager.users.compromyse = import ./home.nix;
  programs.steam.enable = true;

  networking.extraHosts =
  ''
    127.0.0.1 download.labsmartlis.local
  '';
}
