{ pkgs, lib, config, ... }:
let
  # RTX 3070 Ti
  gpuIDs = [
    "10de:28e0" # Graphics
    "10de:22be" # Audio
  ];
in {
  boot = {
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"

      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    kernelParams = [
      ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs)
    ];
  };
}
