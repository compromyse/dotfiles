{ pkgs, config, lib, ... }:

let
  gpuIDs = [
    "10de:28e0"
    "10de:22be"
  ];
in
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

    docker.enable = true;
  };
  services.spice-vdagentd.enable = true;
  programs.virt-manager.enable = true;

  systemd.tmpfiles.rules = [ "f /dev/shm/looking-glass 0660 compromyse kvm -" ];

  environment.extraOutputsToInstall = [ "dev" ];
  environment.systemPackages = [
    pkgs.looking-glass-client
    pkgs.libvirt
    pkgs.virt-viewer
    pkgs.guestfs-tools
    #pkgs.vagrant

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

    (pkgs.writeShellScriptBin "vfio-bind" ''
      sudo modprobe -r nvidia_drm nvidia_modeset nvidia_uvm i2c_nvidia_gpu nvidia

      sudo modprobe vfio
      sudo modprobe vfio_iommu_type1
      sudo modprobe vfio_pci

      systemctl --user -M compromyse@ stop pipewire.service pipewire.socket

      sudo virsh nodedev-detach pci_0000_01_00_0
      sudo virsh nodedev-detach pci_0000_01_00_1

      systemctl --user -M compromyse@ restart pipewire.service pipewire.socket
    '')

    (pkgs.writeShellScriptBin "vfio-unbind" ''
      systemctl --user -M compromyse@ stop pipewire.service pipewire.socket

      sudo virsh nodedev-reattach pci_0000_01_00_0
      sudo virsh nodedev-reattach pci_0000_01_00_1

      systemctl --user -M compromyse@ restart pipewire.service pipewire.socket

      sudo modprobe -r vfio_pci
      sudo modprobe -r vfio_iommu_type1
      sudo modprobe -r vfio

      sudo modprobe nvidia_drm nvidia_modeset nvidia_uvm i2c_nvidia_gpu nvidia
    '')
  ];

  boot = {
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
    ];

    kernelParams = [
      "modprobe.blacklist=nvidia,nvidia_modeset,nvidia_uvm,nvidia_drm"
      "skippatcheck"
      "pci_acs_override=downstream,multifunction"
      ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs)
    ];
  };

  boot.extraModprobeConfig = ''
    options vfio-pci ids=${lib.concatStringsSep "," gpuIDs}
  '';

  # Use the custom kernel package set
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # boot.kernelPatches = [
  #   {
  #     # https://github.com/Kinsteen/win10-gpu-passthrough/blob/main/pat_patch.diff
  #     name = "disable-pat-check";
  #     patch = ../dist/disable-pat-check.patch;
  #   }
  #   {
  #     # https://aur.archlinux.org/cgit/aur.git/tree/1001-6.8.0-add-acs-overrides.patch?h=linux-vfio
  #     name = "acso";
  #     patch = ../dist/acso.patch;
  #   }
  # ];
}
