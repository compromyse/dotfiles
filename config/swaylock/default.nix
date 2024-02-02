{ pkgs, config, ... }:

{
  home.packages = [ pkgs.swaylock pkgs.swayidle ];
  home.file.".config/swaylock/config".source = ./config;
}
