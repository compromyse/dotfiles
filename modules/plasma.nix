{ pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    elisa
    ark
    gwenview
    okular
    kate
    khelpcenter
    dolphin
    dolphin-plugins
    baloo-widgets
    krdp
  ];

  # services.power-profiles-daemon.enable = false;
}
