{ pkgs, config, ... }:

{
  xdg.configFile."qtile/config.py".source = ./config.py;
}
