{ config, ... }:

let
  derpPort = 3478;
in {
  services = {
    headscale = {
      enable = true;
      port = 8085;
      address = "127.0.0.1";
      settings = {
        dns = {
          override_local_dns = true;
          base_domain = "me";
          magic_dns = true;
          nameservers.global = ["8.8.8.8"];
        };
        server_url = "https://headscale.compromyse.xyz";
        metrics_listen_addr = "127.0.0.1:8095";
        logtail.enabled = false;
        log.level = "warn";
        derp.server = {
          enable = true;
          region_id = 999;
          stun_listen_addr = "0.0.0.0:${toString derpPort}";
        };
      };
    };

    nginx.virtualHosts = {
      "headscale.compromyse.xyz" = {
        forceSSL = true;
        enableACME = true;
        locations = {
          "/" = {
            proxyPass = "http://localhost:${toString config.services.headscale.port}";
            proxyWebsockets = true;
          };
          "/metrics" = {
            proxyPass = "http://${config.services.headscale.settings.metrics_listen_addr}/metrics";
          };
        };
      };
    };
  };

  # Derp server
  networking.firewall.allowedUDPPorts = [derpPort];

  environment.systemPackages = [config.services.headscale.package];
}
