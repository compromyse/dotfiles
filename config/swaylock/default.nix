{ pkgs, config, ... }:

let
  swaylockPkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/05bbf675397d5366259409139039af8077d695ce.tar.gz";
    sha256 = "1r26vjqmzgphfnby5lkfihz6i3y70hq84bpkwd43qjjvgxkcyki0";
  }) { system = "x86_64-linux"; };
  swaylock = swaylockPkgs.swaylock;
in {
  home.packages = [ swaylock pkgs.swayidle ];
  home.file.".config/swaylock/config".source = ./config;
}
