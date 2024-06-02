{ pkgs, config, ... }:

{
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd
    amdvlk
    vaapiVdpau
    libvdpau-va-gl
  ];

  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  services.xserver.videoDrivers = [ "modesetting" ];

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
}
