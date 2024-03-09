{ pkgs, ... }:

let
  nix_path = "/tmp/nix_path";
in {
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    nixPath = [ "nixpkgs=${nix_path}" ];
  };

  systemd.tmpfiles.rules = [
    "L+ ${nix_path} - - - - ${pkgs.path}"
  ];

  time.timeZone = "Asia/Kolkata";

  networking.networkmanager.enable = true;

  security.rtkit.enable = true;

  system.stateVersion = "23.11";
}
