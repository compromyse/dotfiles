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

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "ong" ''
      echo "\_SB.AMW3.WMAX 0 0x15 {1, 0xab, 0x00, 0x00}" > /proc/acpi/call
      echo "\_SB.AMW3.WMAX 0 0x15 {1, 0xab, 0x00, 0x00}" > /proc/acpi/call
      echo "\_SB.AMW3.WMAX 0 0x15 {1, 0xab, 0x00, 0x00}" > /proc/acpi/call
      echo "\_SB.AMW3.WMAX 0 0x15 {1, 0xab, 0x00, 0x00}" > /proc/acpi/call
      echo "\_SB.AMW3.WMAX 0 0x15 {1, 0xab, 0x00, 0x00}" > /proc/acpi/call
    '')

    (pkgs.writeShellScriptBin "offg" ''
      echo "\_SB.AMW3.WMAX 0 0x15 {1, 0xa0, 0x00, 0x00}" > /proc/acpi/call
      echo "\_SB.AMW3.WMAX 0 0x15 {1, 0xa0, 0x00, 0x00}" > /proc/acpi/call
      echo "\_SB.AMW3.WMAX 0 0x15 {1, 0xa0, 0x00, 0x00}" > /proc/acpi/call
      echo "\_SB.AMW3.WMAX 0 0x15 {1, 0xa0, 0x00, 0x00}" > /proc/acpi/call
      echo "\_SB.AMW3.WMAX 0 0x15 {1, 0xa0, 0x00, 0x00}" > /proc/acpi/call
    '')
  ];
}
