{ config, ... }:

{
  users.users.compromyse = {
    initialPassword = "changeme";
    isNormalUser = true;
    # openssh.authorizedKeys.keys = [];
    extraGroups = [ "wheel" "video" "storage" "input" "plugdev" "libvirtd" "docker" "kvm" ];
  };
}
