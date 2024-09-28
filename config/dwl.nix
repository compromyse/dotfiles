{ pkgs, home, ... }:

let
  dwl = (pkgs.callPackage ../packages/dwl.nix {});
  dwlb = (pkgs.callPackage ../packages/dwlb.nix {});
in {
  home.packages = [ dwl dwlb ];
}
