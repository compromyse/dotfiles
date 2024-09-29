{ pkgs, home, ... }:

let
  wlroots = pkgs.callPackage ../packages/wlroots.nix {};
  dwl = (pkgs.callPackage ../packages/dwl.nix { inherit wlroots; });
  dwlb = (pkgs.callPackage ../packages/dwlb.nix {});
in {
  home.packages = [ dwl dwlb ];
}
