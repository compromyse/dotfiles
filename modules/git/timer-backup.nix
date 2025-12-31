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

      FILENAME=repositories-$(date +%s).tar
      FILE=/tmp/$FILENAME

      REPOSITORIES=$(ls $HOME)
      ${pkgs.gnutar}/bin/tar cf $FILE $REPOSITORIES
      ${pkgs.openssh}/bin/scp $FILE compromyse@owo.compromyse.xyz:~/backups/$FILENAME

      rm -f $FILE
    '';

    serviceConfig = {
      Type = "oneshot";
      User = "git";
    };
  };
}
