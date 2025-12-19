{ pkgs, config, ... }:

{
  home.packages = [ pkgs.qtile ];
  xdg.configFile."qtile".source = ./qtile;
}
