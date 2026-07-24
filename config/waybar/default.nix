{ pkgs, config, ... }:


let
  waybar = pkgs.callPackage ../../packages/waybar.nix {};
in {
  home.packages = [ waybar ];

  home.file.".config/waybar/config".source = ./config;
  home.file.".config/waybar/style.css".source = ./style.css;
}
