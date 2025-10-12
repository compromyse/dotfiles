{ pkgs, config, ... }:

{
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
    vaapiVdpau
    libvdpau-va-gl
  ];

  services.xserver.videoDrivers = [ "modesetting" ];

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
}
