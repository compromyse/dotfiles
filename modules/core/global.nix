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

  boot.kernelPackages = pkgs.linuxPackages_zen;

  systemd.tmpfiles.rules = [
    "L+ ${nix_path} - - - - ${pkgs.path}"
  ];

  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
  ];

  time.timeZone = "Asia/Kolkata";

  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  networking.nameservers = [ "1.1.1.1" ];

  security.rtkit.enable = true;

  system.stateVersion = "23.11";
}
