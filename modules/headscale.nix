{ pkgs, config, lib, ... }:

let
  basedomain = "compromyse.xyz";
  subdomain = "headscale";
in {
  services = {
    headscale = {
      enable = true;
      address = "0.0.0.0";
      port = 8080;
      server_url = "https://${subdomain}.${basedomain}";
      dns = { baseDomain = basedomain; };
      settings = { logtail.enabled = false; };
    };

    nginx.virtualHosts."${subdomain}.${basedomain}" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass =
          "http://localhost:${toString config.services.headscale.port}";
        proxyWebsockets = true;
      };
    };
  };

  environment.systemPackages = [ config.services.headscale.package ];
}
