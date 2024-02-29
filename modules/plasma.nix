{ pkgs, ... }:

{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  services.xserver.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
}
