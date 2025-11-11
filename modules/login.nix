{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tuigreet
    greetd
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # command = "tuigreet --time --remember --cmd sway";
        # command = "tuigreet --time --remember --cmd labwc";
        # command = "tuigreet --time --remember --cmd \"dwl -s dwlb\"";
        command = "tuigreet --time --remember --cmd dwl";
        user = "greeter";
      };
    };
  };

  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
  };

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

  security.pam.services.swaylock.text = ''
    auth include login
  '';
  security.pam.loginLimits = [
    { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
  ];

  services.libinput.enable = true;

  programs.gnupg.agent = {
    enable = true;
  };

  programs.dconf.enable = true;

  environment.sessionVariables = {
    __EGL_VENDOR_LIBRARY_FILENAMES = "${pkgs.mesa.outPath}/share/glvnd/egl_vendor.d/50_mesa.json";
    __GLX_VENDOR_LIBRARY_NAME = "mesa";
  };
}
