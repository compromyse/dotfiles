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

  environment.extraOutputsToInstall = [ "dev" ];
  environment.systemPackages = [
    pkgs.looking-glass-client
    pkgs.libvirt
    pkgs.vagrant

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

  boot.kernelPatches = [
    {
      # https://github.com/Kinsteen/win10-gpu-passthrough/blob/main/pat_patch.diff
      name = "disable-pat-check";
      patch = ../dist/disable-pat-check.patch;
    }
    {
      # https://aur.archlinux.org/cgit/aur.git/tree/1001-6.8.0-add-acs-overrides.patch?h=linux-vfio
      name = "acso";
      patch = ../dist/acso.patch;
    }
  ];

  boot.kernelParams = [ "skippatcheck" "pcie_acs_override=downstream,multifunction" ];
}
