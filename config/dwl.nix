{ pkgs, home, fetchFromGitHub, ... }:

let
  dwl-custom = (pkgs.callPackage ../packages/dwl-custom.nix {});
in {
  home.packages = [ dwl-custom ];
}
