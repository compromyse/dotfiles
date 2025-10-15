{ config, lib, pkgs, ... }:

{
  systemd.timers."backup-repositories" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
        Unit = "backup-repositories.service";
      };
  };

  systemd.services."backup-repositories" = {
    script = ''
      mkdir -p $HOME/backups

      REPOSITORIES=!(backups)
      tar cf $HOME/backups/repositories-$(date +%s).tar $REPOSITORIES

      find $HOME/backups -mtime 5 -delete
    '';

    serviceConfig = {
      Type = "oneshot";
      User = "git";
    };
  };
}
