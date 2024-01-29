{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./OwO.nix
    ./home.nix
    ./desktop.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [
    waybar
    fuzzel
    dunst
    hyprpaper
    swaylock

    networkmanagerapplet

    greetd.tuigreet
    greetd.greetd
    polkit_gnome

    libnotify
    libappindicator

    cudatoolkit
  ];

  system.stateVersion = "23.11";
}

