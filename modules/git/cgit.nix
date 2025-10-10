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
      enable-http-clone = true;

      enable-commit-graph = true;
      enable-follow-links = true;
      source-filter = "${pkgs.cgit}/lib/cgit/filters/syntax-highlighting.py";

      head-include=/config/modules/git/cgit_theme.css
    };
    nginx.virtualHost = "git.compromyse.xyz";
  };
}
