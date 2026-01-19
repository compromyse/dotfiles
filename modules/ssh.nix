{ pkgs, config, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
    };
  };

  environment.systemPackages = with pkgs; [
    sshfs
  ];
}
