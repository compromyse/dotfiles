{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    networkmanagerapplet

    polkit_gnome

    libnotify
    libappindicator

    inotify-tools
  ];
}
