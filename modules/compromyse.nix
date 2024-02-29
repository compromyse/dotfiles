{ config, ... }:

{
  users.users.compromyse = {
    initialPassword = "changeme";
    isNormalUser = true;
    # openssh.authorizedKeys.keys = [];
    extraGroups = [ "wheel" "storage" "input" "plugdev" "libvirtd" "lxd" "docker" ];
  };
}
