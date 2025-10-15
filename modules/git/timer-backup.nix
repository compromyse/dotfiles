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
      cd $HOME
      mkdir -p $HOME/backups

      FILENAME=repositories-$(date +%s).tar
      FILE=$HOME/backups/$FILENAME

      REPOSITORIES=$(ls $HOME | grep -v backups)
      tar cf $FILE $REPOSITORIES
      scp $FILE compromyse@owo.compromyse.xyz:~/backups/$FILENAME

      find $HOME/backups -mtime 7 -delete
    '';

    serviceConfig = {
      Type = "oneshot";
      User = "git";
    };
  };
}
