{ inputs, pkgs, ... }:

{
  home = {
    username = "git";
    homeDirectory = "/home/git";
  };

  home.packages = with pkgs; [
    git-lfs
  ];

  imports = (map (path: ../../config/${path}) [
    "git"
    "nvim"
  ]);

  home.stateVersion = "23.11";
}
