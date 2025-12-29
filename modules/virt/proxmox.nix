{ pkgs, lib, ... }:

{
  services.proxmox-ve = {
    enable = true;
    ipAddress = "0.0.0.0";
  };

  nixpkgs.overlays = [
    proxmox-nixos.overlays.${system}
  ];

  # Make vmbr0 bridge visible in Proxmox web interface
  services.proxmox-ve.bridges = [ "vmbr0" ];

  # Actually set up the vmbr0 bridge
  networking.bridges.vmbr0.interfaces = [ "ens18" ];
  networking.interfaces.vmbr0.useDHCP = lib.mkDefault true;
}
