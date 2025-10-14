{ config, lib, pkgs, ... }:

{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "* * * * *      git    git-shell -c update-timestamps"
    ];
  };
}
