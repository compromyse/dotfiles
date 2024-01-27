{ config, pkgs, ... }:

{
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  networking.hostName = "OwO";

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.production;

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  fileSystems."/data" = {
    device = "/dev/sda";
    fsType = "ext4";
  };

  time.timeZone = "Asia/Kolkata";
}
