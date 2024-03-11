{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
    greetd.greetd
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "tuigreet --time --remember --cmd \"dwm\"";
        user = "greeter";
      };
    };
  };

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  security.polkit.enable = true;

  services.xserver.libinput.enable = true;

  programs.gnupg.agent = {
    enable = true;
  };

  programs.dconf.enable = true;
}
