{ pkgs, config, ... }:

{
  home.packages = with pkgs; [ labwc ];

  home.file.".config/labwc/rc.xml".source = ./rc.xml;
  home.file.".config/labwc/autostart".source = ./autostart;
  home.file.".themes/gruvbox-material-dark-blocks".source = ./gruvbox-material-dark-blocks;
}
