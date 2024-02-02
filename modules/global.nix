{ pkgs, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  time.timeZone = "Asia/Kolkata";

  networking.networkmanager.enable = true;

  security.rtkit.enable = true;

  /* environment.etc."inputrc".text = pkgs.lib.mkForce ''
    set completion-ignore-case on
  ''; */

  system.stateVersion = "23.11";
}
