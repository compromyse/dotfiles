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
    channel.enable = false;
  };

  systemd.tmpfiles.rules = [
    "L+ ${nix_path} - - - - ${pkgs.path}"
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
  ];

  time.timeZone = "America/New_York";
  # time.timeZone = "Asia/Kolkata";

  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  networking.nameservers = [ "1.1.1.1" ];

  security.rtkit.enable = true;

  programs.ssh.extraConfig = ''
    StrictHostKeyChecking no
  '';

  security.acme = {
    acceptTerms = true;
    defaults.email = "raghus2247@gmail.com";
  };

  system.stateVersion = "23.11";
}
