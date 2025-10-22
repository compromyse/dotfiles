{ config, lib, pkgs, ... }:

{
  systemd.timers."clean-backups" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
        Unit = "clean-backups.service";
      };
  };

  systemd.services."clean-backups" = {
    script = ''
      find $HOME/backups -mtime 7 -delete
    '';

    serviceConfig = {
      Type = "oneshot";
      User = "compromyse";
    };
  };
}
