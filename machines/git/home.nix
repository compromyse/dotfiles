{ inputs, pkgs, ... }:

{
  home = {
    username = "compromyse";
    homeDirectory = "/home/compromyse";
  };

  home.packages = with pkgs; [
    git-lfs
  ];

  imports = (map (path: ../../config/${path}) [
    "bash.nix"
    "git"
  ]);

  home.stateVersion = "23.11";
}
