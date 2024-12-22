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

    "nvidia.nix"
    "amdgpu.nix"
    "amd.nix"
    "laptop.nix"

    "core/audio.nix"
    "core/bluetooth.nix"
    "core/fonts.nix"

    "compromyse.nix"

    "virtualization.nix"
    "remapcapslock.nix"

    "wm_utils.nix"
    "polkit.nix"
    "login.nix"
    # "plasma.nix"
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
    grub2-theme = {
      enable = true;
      theme = "vimix";
      footer = true;
      customResolution = "1920x1080";
    };
  };

  boot.extraModprobeConfig = "options kvm_amd nested=1";

  services.fstrim.enable = true;

  networking.hostName = "x";

  programs.fuse.userAllowOther = true;
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "compromyse" = import ./home.nix;
    };
  };

  programs.adb.enable = true;

  services.printing.enable = true;
  services.printing.drivers = [
    pkgs.brlaser
  ];

  networking.extraHosts = ''
    192.168.122.100 android
    192.168.122.101 deb
    141.148.221.227 o
  '';

  programs.ssh.extraConfig = ''
    Host o
      User ubuntu
  '';
}
