{ lib, config, ... }:
let
  kver = config.boot.kernelPackages.kernel.version;
in
{
  boot.kernelParams = [ "amd_pstate=active" "amd_iommu=on" ];
  hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
}
