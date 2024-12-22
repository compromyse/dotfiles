{ config, ... }:

{
  users.users.compromyse = {
    hashedPassword = "$y$j9T$QfsPs3aK5iQOzctkQglAp1$00VuaoJthM6hNxnoMsx58CbI3rsFDem5xtsKqPRfy4C";
    isNormalUser = true;
    # openssh.authorizedKeys.keys = [];
    extraGroups = [ "wheel" "video" "storage" "input" "plugdev" "libvirtd" "docker" "kvm" "lp" ];
  };
}
