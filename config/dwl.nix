{ pkgs, home, fetchFromGitHub, ... }:

let
  dwl = (pkgs.callPackage ../packages/dwl.nix {});
  dwlb = (pkgs.callPackage ../packages/dwlb.nix {});
in {
  xdg.portal.enable = true;
  xdg.portal.configPackages = [ pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-wlr ];
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-wlr ];

  home.packages = [ dwl dwlb ];
}
