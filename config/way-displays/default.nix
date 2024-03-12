{ pkgs, config, ... }:

{
  home.packages = [ pkgs.way-displays ];
  home.file.".config/way-displays/cfg.yaml".source = ./cfg.yaml;
}
