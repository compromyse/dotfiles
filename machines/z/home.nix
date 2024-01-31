{ pkgs, ... }:

{

  home = {
    username = "compromyse";
    homeDirectory = "/home/compromyse";
  };

  imports = [
    ../../config/themes.nix
    ../../config/alacritty
  ];

  home.packages = with pkgs; [
    wget
  ];

  home.stateVersion = "23.11";
}
