{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    polkit_gnome

    libnotify
    libappindicator

    inotify-tools

    wirelesstools
    pamixer
    brightnessctl
    wbg
    networkmanagerapplet

    sway-launcher-desktop
  ];

  services.dbus.enable = true;
}
