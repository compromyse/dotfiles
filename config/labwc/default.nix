{ home, pkgs, ... }:

{
  home.packages = with pkgs; [
    labwc
  ];

  # home.file.".config/sway/config".source = ./config;
}
