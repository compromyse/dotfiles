{ pkgs, config, ... }:

{
  home.packages = [ fuzzel ];
  home.file.".config/fuzzel/fuzzel.ini".source = ./fuzzel.ini;
}
