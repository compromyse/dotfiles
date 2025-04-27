{ pkgs, ... }:

{
  services.xserver.desktopManager.mate = {
    enable = true;
    enableWaylandSession = true;
  };
}
