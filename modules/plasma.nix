{ pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    # konsole
    ark
    elisa
    gwenview
    kate
    khelpcenter
    dolphin
    baloo-widgets
    dolphin-plugins
    ffmpegthumbs
    krdp
    discover
  ];

  services.power-profiles-daemon.enable = false;
}
