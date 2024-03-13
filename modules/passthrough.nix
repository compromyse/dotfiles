{ pkgs, lib, config, ... }:

{
  environment.systemPackages = with pkgs; [
    supergfxctl
  ];

  services.supergfxd.enable = true;

  environment.etc."supergfxd.conf" = {
    source = ./supergfxd.conf;
    mode = "0644";
  };
}
