{ inputs, lib, ... }:

{
  services.proxmox-ve = {
    enable = true;
    ipAddress = "0.0.0.0";
  };

  nixpkgs.overlays = [
    inputs.proxmox-nixos.overlays.x86_64-linux
  ];

  # Make vmbr0 bridge visible in Proxmox web interface
  services.proxmox-ve.bridges = [ "vmbr0" ];

  # Actually set up the vmbr0 bridge
  networking.bridges.vmbr0.interfaces = [ "enp2s0" ];
  networking.interfaces.vmbr0.useDHCP = lib.mkDefault true;
}
