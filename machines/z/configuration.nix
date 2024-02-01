{ lib, inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ] ++ (map (path: ../../modules/${path}) [
    "global.nix"
    "compromyse.nix"
    "desktop.nix"
    "login.nix"
    "fonts.nix"
    "bluetooth.nix"
    "audio.nix"
    # "virtualization.nix"
  ]);

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.extraModprobeConfig = "options kvm_intel nested=1";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  hardware.opengl.enable = true;

  fileSystems."/data" = {
    device = "/dev/sda";
    fsType = "ext4";
  };

  networking.hostName = "z";

  home-manager.users.compromyse = import ./home.nix;
}
