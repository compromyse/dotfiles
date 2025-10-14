{ inputs, pkgs, lib, ... }:

{
  home = {
    username = "git";
    homeDirectory = lib.mkForce "/home/git";
  };

  home.packages = with pkgs; [
    jq
    git-lfs
  ];

  imports = (map (path: ../../config/${path}) [
    "git"
    "nvim"
  ]);

  home.stateVersion = "23.11";
}
