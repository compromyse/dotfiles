{ pkgs, ... }:

{

  home = {
    username = "compromyse";
    homeDirectory = "/home/compromyse";
  };

  imports = (map (path: ../../config/${path}) [
    "themes.nix"
    "dotfiles.nix"
    "git"
    "alacritty"
  ]);


  home.packages = with pkgs; [
    wget
  ];

  home.stateVersion = "23.11";
}
