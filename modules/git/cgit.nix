{ config, pkgs, ... }:

let
  repositoryPath = "/home/compromyse";
in {
  services.cgit."git.compromyse.xyz" = {
    enable = true;
    user = "root";
    group = "root";
    scanPath = repositoryPath;
    settings = {
      root-title = "compromyse: CGIT";
      root-desc = "Compromyse's Git Repositories";
      enable-follow-links = true;
      source-filter = "${pkgs.cgit}/lib/cgit/filters/syntax-highlighting.py";
    };
    nginx.virtualHost = "git.compromyse.xyz";
  };
}
