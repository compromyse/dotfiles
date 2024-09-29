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
    "laptop.nix"

    "core/audio.nix"
    "core/bluetooth.nix"
    "core/fonts.nix"

    "compromyse.nix"
    "login.nix"
    "polkit.nix"

    "virtualization.nix"
    "remapcapslock.nix"

    "wm_utils.nix"
    # "qtile"
  ]);

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.extraModprobeConfig = "options kvm_amd nested=1";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  services.fstrim.enable = true;

  networking.hostName = "x";

  home-manager.users.compromyse = import ./home.nix;

  environment.variables = {
    XCURSOR_SIZE = "16";
  };

  networking.extraHosts =
  ''
    127.0.0.1 download.labsmartlis.local
    192.168.1.186 cacer.local c
  '';
}
