{ pkgs, config, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;

    docker = {
      enable = true;
    };
  };
  services.spice-vdagentd.enable = true;
  programs.virt-manager.enable = true;

  systemd.tmpfiles.rules = [ "f /dev/shm/looking-glass 0660 compromyse kvm -" ];

  environment.systemPackages = [
    pkgs.looking-glass-client

    (pkgs.writeShellScriptBin "bind-vfio" ''
      modprobe -r nvidia_drm nvidia_modeset nvidia_uvm i2c_nvidia_gpu nvidia

      modprobe vfio
      modprobe vfio_iommu_type1
      modprobe vfio_pci

      systemctl --user -M compromyse@ stop pipewire.service pipewire.socket

      virsh nodedev-detach pci_0000_01_00_0
      virsh nodedev-detach pci_0000_01_00_1

      systemctl --user -M compromyse@ restart pipewire.service pipewire.socket
    '')

    (pkgs.writeShellScriptBin "unbind-vfio" ''
      systemctl --user -M compromyse@ stop pipewire.service pipewire.socket

      virsh nodedev-reattach pci_0000_01_00_0
      virsh nodedev-reattach pci_0000_01_00_1

      systemctl --user -M compromyse@ restart pipewire.service pipewire.socket

      modprobe -r vfio_pci
      modprobe -r vfio_iommu_type1
      modprobe -r vfio

      modprobe nvidia_drm nvidia_modeset nvidia_uvm i2c_nvidia_gpu nvidia
    '')

    (pkgs.writeShellScriptBin "pin-cpu" ''
      if [[ $1 == "" ]]; then
        cpus="8-15"
      else
        cpus=$1
      fi
      systemctl set-property --runtime -- user.slice AllowedCPUs="$cpus"
      systemctl set-property --runtime -- system.slice AllowedCPUs="$cpus"
      systemctl set-property --runtime -- init.scope AllowedCPUs="$cpus"
    '')

    (pkgs.writeShellScriptBin "unpin-cpu" ''
      systemctl set-property --runtime -- user.slice AllowedCPUs=""
      systemctl set-property --runtime -- system.slice AllowedCPUs=""
      systemctl set-property --runtime -- init.scope AllowedCPUs=""
    '')
  ];
}
