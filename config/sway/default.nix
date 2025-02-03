{ home, pkgs, ... }:

{
  home.packages = with pkgs; [
    sway
    autotiling-rs
  ];

  home.file.".config/sway/config".source = ./config;
}
