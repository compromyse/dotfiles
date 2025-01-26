{ pkgs, config, ... }:

{
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    # rocmPackages.clr.icd
    amdvlk
    vaapiVdpau
    libvdpau-va-gl
  ];

  hardware.graphics.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  services.xserver.videoDrivers = [ "modesetting" ];

  /* systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ]; */
}
