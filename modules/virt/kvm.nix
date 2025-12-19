{ pkgs, config, lib, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;

    docker.enable = true;
  };
  services.spice-vdagentd.enable = true;
  programs.virt-manager.enable = true;

  environment.extraOutputsToInstall = [ "dev" ];
  environment.systemPackages = [
    pkgs.libvirt
    pkgs.virt-viewer
    pkgs.guestfs-tools

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
