{ config, lib, pkgs, ... }:

{
  systemd.timers."update-timestamps" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "10s";
        OnUnitActiveSec = "10s";
        Unit = "update-timestamps.service";
      };
  };

  systemd.services."update-timestamps" = {
    script = ''
      REPOSITORIES=$(find /home/git/* -name '*.git' -type d)

      for repo in $REPOSITORIES; do
        cd $repo
        mkdir -p info/web
        echo $(${pkgs.git}/bin/git log -1 --date=iso --format=%ci) > info/web/last-modified
      done
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "git";
    };
  };
}
