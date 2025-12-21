{ lib, ... }:

{
  services.nginx = {
    enable = true;
    virtualHosts."compromyse.xyz" = {
      enableACME = true;
      forceSSL = true;
      root = "/home/www/compromyse.xyz";
    };
  };
}
