{ pkgs, config, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
        permitRootLogin = "no";
        passwordAuthentication = false;
    };
  };
}
