{ pkgs, config, lib, ... }:

{
  services.xserver.windowManager.qtile.enable = true;

  # environment.sessionVariables = {
  #   MOZ_ENABLE_WAYLAND = "1";
  #   XDG_SESSION_TYPE = "wayland";
  #   XDG_CURRENT_DESKTOP = "wlroots";
  #   SDL_VIDEODRIVER = "wayland";
  #   QT_QPA_PLATFORM = "wayland";
  #   QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  #   _JAVA_AWT_WM_NONREPARENTING = "1";
  # };
  #
  # services.greetd.settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --remember --cmd ${pkgs.writeScript "startqtile" ''
  #   #!${pkgs.bash}/bin/bash
  #
  #   export XDG_DATA_DIRS=/run/current-system/sw/share/gsettings-schemas:$XDG_DATA_DIRS
  #   systemctl --user unset-environment DISPLAY WAYLAND_DISPLAY
  #
  #   bash --login -c "systemctl --user import-environment XDG_DATA_DIRS PATH"
  #
  #   exec systemctl --user --wait start qtile.service
  # ''}";

  # systemd.user.targets.qtile-session = {
  #   description = "Qtile compositor session";
  #   documentation = [ "man:systemd.special(7)" ];
  #   bindsTo = [ "graphical-session.target" ];
  #   wants = [ "graphical-session-pre.target" ];
  #   after = [ "graphical-session-pre.target" ];
  # };
  #
  # systemd.user.services.qtile = 
  #   let
  #     pyEnv = pkgs.python3.withPackages (_p: with _p; [ qtile iwlib ]);
  #   in {
  #     description = "Qtile Compositor";
  #     documentation = [ "man:qtile(5)" ];
  #     bindsTo = [ "graphical-session.target" ];
  #     wants = [ "graphical-session-pre.target" ];
  #     after = [ "graphical-session-pre.target" ];
  #     environment.PATH = lib.mkForce null;
  #     environment.PYTHONPATH = lib.mkForce null;
  #     serviceConfig = {
  #       Type = "simple";
  #       ExecStart = "${pyEnv}/bin/qtile start -b wayland";
  #       Restart = "on-failure";
  #       RestartSec = 1;
  #       TimoutStopSec = 10;
  #     };
  #   };
}
