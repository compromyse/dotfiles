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
      clone-url = "https://git.compromyse.xyz/$CGIT_REPO_URL";
      enable-commit-graph = 1;
      enable-log-filecount = 1;
      enable-log-linecount = 1;
    };
    nginx.virtualHost = "git.compromyse.xyz";
  };
}
