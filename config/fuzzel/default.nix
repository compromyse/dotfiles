{ pkgs, config, ... }:

{
  home.packages = [ pkgs.fuzzel ];
  home.file.".config/fuzzel/fuzzel.ini".source = ./fuzzel.ini;
}
