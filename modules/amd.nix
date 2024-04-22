{ lib, config, ... }:
let
  kver = config.boot.kernelPackages.kernel.version;
in
{
  boot.kernelParams = [ "amd_pstate=active" "amd_iommu=on" "amdgpu.sg_display=0" ];
  hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
}
