{ pkgs, ... }:

{
  fileSystems."/data" = {
    device = "compromyse@owo.compromyse.xyz:data";
    fsType = "sshfs";
    options = [
      "nodev"
      "noatime"
      "allow_other"
      "IdentityFile=/home/compromyse/.ssh/id_rsa"
    ];
  };
}
