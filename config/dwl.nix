{ pkgs, home, ... }:

let
  wayland-protocols = pkgs.callPackage ../packages/wayland-protocols.nix {};
  wlroots = pkgs.callPackage ../packages/wlroots.nix { inherit wayland-protocols; };
  dwl = (pkgs.callPackage ../packages/dwl.nix { inherit wlroots; inherit wayland-protocols; });
  # dwlb = (pkgs.callPackage ../packages/dwlb.nix {});
in {
  home.packages = [
    dwl
    # dwlb
  ];
}
