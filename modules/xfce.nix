{ pkgs, ... }:

{
  services.xserver.desktopManager.xfce = {
    enable = true;
    enableWaylandSession = true;
  };
}
