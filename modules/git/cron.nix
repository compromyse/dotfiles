{ config, lib, pkgs, ... }:

{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "* * * * *      git    /home/git/git-shell-commands/update-timestamps"
    ];
  };
}
