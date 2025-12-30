{ inputs, lib, ... }:

{
  services.proxmox-ve = {
    enable = true;
    ipAddress = "0.0.0.0";
  };

  nixpkgs.overlays = [
    inputs.proxmox-nixos.overlays.x86_64-linux
  ];

  # Bridges visible in Proxmox web interface
  # This one's created by kvm (virt-manager)
  services.proxmox-ve.bridges = [ "virbr0" ];

  # Sleep stuff
  services.logind.settings.Login.lidSwitchExternalPower = "ignore";
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
