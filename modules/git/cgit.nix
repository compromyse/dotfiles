{ config, pkgs, ... }:

let
  repositoryPath = "/home/compromyse";
in {
  services.cgit."localhost" = {
    enable = true;
    scanPath = repositoryPath;
    settings = {
      root-title = "compromyse: CGIT";
      root-desc = "Compromyse's Git Repositories";
      clone-url = "https://git.compromyse.xyz/$CGIT_REPO_URL";
      enable-commit-graph = 1;
      enable-log-filecount = 1;
      enable-log-linecount = 1;
    };
  };

  services.h2o = {
    enable = true;
    extraConfig = ''
      listen:
        port: 80
        host: 0.0.0.0
      listen:
        port: 443
        host: 0.0.0.0
        ssl:
          certificate-file: /var/lib/acme/git.compromyse.xyz/fullchain.pem
          key-file: /var/lib/acme/git.compromyse.xyz/key.pem

      # Default host configuration
      hosts:
        "*":
          paths:
            "/static/":
              file.dir: ${pkgs.cgit}/cgit

            "/":
              fastcgi.connect:
                unix: /run/cgit.sock
              fastcgi.spawn: "no"
              fastcgi.params:
                SCRIPT_FILENAME: ${pkgs.cgit}/cgit/cgit.cgi
                PATH_INFO: "index.html"

          access-log: /var/log/h2o/git-access.log
          error-log: /var/log/h2o/git-error.log
    '';
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "raghus2247@gmail.com";
    certs."git.compromyse.xyz".webroot = "/var/lib/acme/acme-challenge";
  };
}
