{ pkgs, ... }:

{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    networkmanagerapplet

    polkit_gnome

    pkgs.libnotify
    pkgs.libappindicator
  ];
}
