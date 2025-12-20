{ pkgs, config, ... }:

{
  xdg.configFile."qtile".source = ./qtile;
}
