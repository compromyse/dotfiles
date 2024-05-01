{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    polkit_gnome

    libnotify
    libappindicator

    inotify-tools

    wirelesstools
    pamixer
    wbg
    networkmanagerapplet

    sway-launcher-desktop
  ];
}
