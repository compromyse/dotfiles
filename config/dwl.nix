{ pkgs, home, fetchFromGitHub, ... }:

let
  dwl = (pkgs.callPackage ../packages/dwl.nix {});
in {
  xdg.portal.enable = true;
  xdg.portal.configPackages = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland ];
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland ];

  home.packages = [ dwl ];
}
