{ lib, inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ] ++ (map (path: ../../modules/${path}) [
    "core/global.nix"
    "amdgpu.nix"
    "amd.nix"
    "nvidia.nix"
    "passthrough.nix"
    "core/audio.nix"
    "core/bluetooth.nix"
    "core/fonts.nix"
    "compromyse.nix"
    "login.nix"
    "virtualization.nix"
  ]);

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.extraModprobeConfig = "options kvm_amd nested=1";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  services.fstrim.enable = true;

  networking.hostName = "x";

  home-manager.users.compromyse = import ./home.nix;
  services.xserver.desktopManager.plasma6.enable = true;

  environment.plasma5.excludePackages = with pkgs.kdePackages; [
    konsole
    oxygen
  ];

  networking.extraHosts =
  ''
    127.0.0.1 download.labsmartlis.local
  '';
}
