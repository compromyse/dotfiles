{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    userName = "Raghuram Subramani";
    userEmail = "raghus2247@gmail.com";
  };
}
