{ pkgs, ... }:

let
  wbg = (pkgs.callPackage ../packages/wbg.nix {});
in {
  environment.systemPackages = with pkgs; [
    polkit_gnome

    libnotify
    libappindicator

    inotify-tools

    wirelesstools
    pamixer
    brightnessctl
    networkmanagerapplet

    sway-launcher-desktop
  ] ++ [ wbg ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal ];
  xdg.portal.config.common.default = "wlr";

  environment.variables = {
    XCURSOR_SIZE = "16";
  };

  services.dbus.enable = true;
}
