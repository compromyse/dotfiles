{ pkgs, ... }:

{

  home = {
    username = "compromyse";
    homeDirectory = "/home/compromyse";
  };

  home.packages = with pkgs; [
    wget
  ];

  imports = (map (path: ../../config/${path}) [
    "themes.nix"
    "dotfiles.nix"
    "git"
    "alacritty"
    "dwl.nix"
  ]);

  home.stateVersion = "23.11";
}
