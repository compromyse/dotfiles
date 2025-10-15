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

      REPOSITORIES=$(find /home/git/* -name '*.git' -type d)

    '';

    serviceConfig = {
      Type = "oneshot";
      User = "git";
    };
  };
}
