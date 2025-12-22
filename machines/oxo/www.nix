{ lib, ... }:

{
  systemd.tmpfiles.rules = [
    "d /var/www 0755 www www"
    "d /var/www/compromyse.xyz 0755 www www"
  ];

  services.nginx = {
    enable = true;
    # user = "www";
    # group = "www";
    virtualHosts."compromyse.xyz" = {
      enableACME = true;
      forceSSL = true;
      root = "/var/www/compromyse.xyz";
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "raghus2247@gmail.com";
  };
}
