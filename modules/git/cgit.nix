{ config, pkgs, lib, ... }:

let
  repositoryPath = "/home/compromyse";
  cgit = (pkgs.callPackage ../../packages/cgit.nix {
    dist = ./cgit-dist;
    theme = "monokai";
  });
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
      root-readme = "README.md";

      enable-commit-graph = true;
      enable-follow-links = true;

      source-filter = "${cgit}/lib/cgit/filters/syntax-highlighting.py";
      about-filter = "${cgit}/lib/cgit/filters/about-formatting.sh";

      head-include = "/config/modules/git/cgit-dist/cgit_theme.css";
      virtual-root = "/";
      clone-prefix = "https://git.compromyse.xyz";
      clone-url = "https://git.compromyse.xyz/$CGIT_REPO_URL";

      "mimetype.gif" = "image/gif";
      "mimetype.html" = "text/html";
      "mimetype.jpg" = "image/jpeg";
      "mimetype.jpeg" = "image/jpeg";
      "mimetype.pdf" = "application/pdf";
      "mimetype.png" = "image/png";
      "mimetype.svg" = "image/svg+xml";
    };
  };

  services.fcgiwrap.instances."cgit-git.compromyse.xyz".process.user = "root";
  services.fcgiwrap.instances."cgit-git.compromyse.xyz".socket.user = lib.mkForce "root";
  services.fcgiwrap.instances."cgit-git.compromyse.xyz".socket.group = lib.mkForce "root";

  services.nginx.virtualHosts."git.compromyse.xyz" = {
    forceSSL = true;
    enableACME = true;
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "raghus2247@gmail.com";
  };
}
