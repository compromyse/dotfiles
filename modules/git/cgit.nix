{ config, pkgs, ... }:

let
  repositoryPath = "/home/compromyse";
  cgit = (pkgs.callPackage ../../packages/cgit.nix {});
in {
  services.cgit."git.compromyse.xyz" = {
    enable = true;
    user = "root";
    group = "root";
    package = cgit;
    scanPath = repositoryPath;
    settings = {
      root-title = "compromyse: CGIT";
      root-desc = "Compromyse's Git Repositories";
      enable-http-clone = true;

      enable-commit-graph = true;
      enable-follow-links = true;
      source-filter = "${cgit}/lib/cgit/filters/syntax-highlighting.py";

      head-include = "/config/modules/git/cgit_theme.css";
      virtual-root = "/";
      clone-prefix = "https://git.compromyse.xyz";

      "mimetype.gif" = "image/gif";
      "mimetype.html" = "text/html";
      "mimetype.jpg" = "image/jpeg";
      "mimetype.jpeg" = "image/jpeg";
      "mimetype.pdf" = "application/pdf";
      "mimetype.png" = "image/png";
      "mimetype.svg" = "image/svg+xml";
    };
    nginx.virtualHost = "git.compromyse.xyz";
  };
}
