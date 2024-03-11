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
    "core/audio.nix"
    "core/bluetooth.nix"
    "core/fonts.nix"
    "polkit.nix"
    "compromyse.nix"
    "login.nix"
    "wm_utils.nix"
    "virtualization.nix"
  ]);

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.extraModprobeConfig = "options kvm_amd nested=1";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  networking.hostName = "x";

  home-manager.users.compromyse = import ./home.nix;

  networking.extraHosts =
  ''
    127.0.0.1 download.labsmartlis.local
  '';
}
