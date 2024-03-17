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
        command = "tuigreet --time --remember --cmd \"startplasma-wayland\"";
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

  security.pam.services.swaylock.text = ''
    auth include login
  '';

  services.xserver.libinput.enable = true;

  programs.gnupg.agent = {
    enable = true;
  };

  programs.dconf.enable = true;

  environment.sessionVariables = {
    __EGL_VENDOR_LIBRARY_FILENAMES = "${pkgs.mesa_drivers.outPath}/share/glvnd/egl_vendor.d/50_mesa.json";
    __GLX_VENDOR_LIBRARY_NAME = "mesa";
  };
}
