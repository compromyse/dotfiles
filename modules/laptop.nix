{ pkgs, config, ... }:

{
  /* services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    };
  }; */

  boot = {
    kernelModules = [ "acpi_call" ];
    extraModulePackages = [ config.boot.kernelPackages.acpi_call ];
  };
}
