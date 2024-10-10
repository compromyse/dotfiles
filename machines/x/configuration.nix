{ lib, inputs, pkgs, ... }:

let
  drive = "/dev/nvme0n1";
in {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default

    (import ../../disko.nix { device = drive; })

  ] ++ (map (path: ../../modules/${path}) [
    "core/global.nix"
    "core/impermanence.nix"

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
  ]);

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = drive;
    };
  };

  boot.extraModprobeConfig = "options kvm_amd nested=1";

  services.fstrim.enable = true;

  networking.hostName = "x";

  environment.variables = {
    XCURSOR_SIZE = "16";
  };

  programs.fuse.userAllowOther = true;
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "compromyse" = import ./home.nix;
    };
  };

  networking.extraHosts =
  ''
    127.0.0.1 download.labsmartlis.local
    192.168.1.186 cacer.local c
  '';
}
