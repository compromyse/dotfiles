{ pkgs, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  time.timeZone = "Asia/Kolkata";

  networking.networkmanager.enable = true;

  security.rtkit.enable = true;

  system.stateVersion = "23.11";
}
