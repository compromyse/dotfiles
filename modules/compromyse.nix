{ config, ... }:

{
  users.users.compromyse = {
    hashedPassword = "$y$j9T$sLByWUVQIl0D6AzHKpVat/$VAsX7YK1NCy2H4XxhVTKdkhWXHuzdMMHq6tC4liH879";
    isNormalUser = true;
    # openssh.authorizedKeys.keys = [];
    extraGroups = [ "wheel" "video" "storage" "input" "plugdev" "libvirtd" "docker" "kvm" "lp" ];
  };
  security.sudo.wheelNeedsPassword = false;
}
