{ pkgs, config, ... }:

{
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;

  boot = {
    kernelModules = [ "acpi_call" ];
    extraModulePackages = [ config.boot.kernelPackages.acpi_call ];
  };

  services.libinput.enable = true;
}
