{ config, ... }:

let
  repositoryPath = "/home/compromyse";
in {
  services.cgit = {
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

  services.fcgiwrap.enable = true;

  services.nginx = {
    enable = true;
    virtualHosts."git.compromyse.com" = {
      # forceSSL = true;
      # enableACME = true;
      root = "${pkgs.cgit}/cgit";
      locations."/" = {
        extraConfig = ''
          include ${pkgs.cgit}/cgit/cgit.conf;
          fastcgi_pass unix:${config.services.fcgiwrap.socketAddress};
          fastcgi_param SCRIPT_FILENAME ${pkgs.cgit}/cgit/cgit.cgi;
          fastcgi_param PATH_INFO $uri;
          include ${pkgs.nginx}/conf/fastcgi_params;
        '';
      };
    };
  };

  # security.acme.acceptTerms = true;
  # security.acme.defaults.email = "raghus2247@gmail.com";
}
