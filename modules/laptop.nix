{ pkgs, config, ... }:

{
  # services.tlp.enable = true;
  # services.power-profiles-daemon.enable = false;

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
       governor = "powersave";
       turbo = "never";
    };
    charger = {
       governor = "performance";
       turbo = "auto";
    };
  };

  boot = {
    kernelModules = [ "acpi_call" ];
    extraModulePackages = [ config.boot.kernelPackages.acpi_call ];
  };

  services.libinput.enable = true;
}
