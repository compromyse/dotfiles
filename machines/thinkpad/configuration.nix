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

    "arc.nix"

    "laptop.nix"
    "fingerprint.nix"

    "core/audio.nix"
    "core/bluetooth.nix"
    "core/fonts.nix"

    "compromyse.nix"
    "remapcapslock.nix"

    "virt/kvm.nix"

    "login.nix"
    "plasma.nix"
    # "wm_utils.nix"
    # "polkit.nix"
    # "mate.nix"
    # "xfce.nix"
    # "gnome.nix"

    # "sshfs-owo.nix"

    "tailscale.nix"
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
      customResolution = "1920x1200";
    };
  };

  boot.extraModprobeConfig = "options kvm_intel nested=1";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.fstrim.enable = true;

  networking.hostName = "thinkpad";

  programs.fuse.userAllowOther = true;
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ inputs.plasma-manager.homeModules.plasma-manager ];
    users = {
      "compromyse" = import ./home.nix;
    };
  };

  programs.adb.enable = true;

  programs.nix-ld.enable = true;

  networking.extraHosts = ''
    178.156.200.181 owo
    5.161.107.13 oxo
    128.205.217.95 esc
    192.168.122.100 deb
  '';

  time.timeZone = lib.mkForce "America/Los_Angeles";
}
