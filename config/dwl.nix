{ pkgs, home, fetchFromGitHub, ... }:

let
  dwl = (pkgs.callPackage ../packages/dwl.nix {});
  dwlb = (pkgs.callPackage ../packages/dwlb.nix {});
in {
  /* xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal ];
  xdg.portal.config.common.default = "wlr"; */

  home.packages = [ dwl dwlb ];
}
