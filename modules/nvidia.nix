{ pkgs, config, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics.enable32Bit = true;

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # hardware.nvidia-container-toolkit.enable = true;

  environment.systemPackages = [
    pkgs.cudatoolkit
    # pkgs.nvidia-container-toolkit
  ];
}
