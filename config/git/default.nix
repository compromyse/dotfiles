{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    userName = "Raghuram Subramani";
    userEmail = "raghus2247@gmail.com";
    extraConfig = {

      init = {
        defaultBranch = "main";
      };

      format = {
        signoff = true;
      };

      url = {

        "git@github.com:" = {
          insteadOf = [
            "github:"
          ];
        };

        "git@github.com:compromyse/" = {
          insteadOf = [
            "compromyse:"
          ];
        };

        "git@git.compromyse.xyz:" = {
          insteadOf = [
            "oxo:"
          ];
        };

      };

      "filter \"lfs\"" = {
         clean = "${pkgs.git-lfs}/bin/git-lfs clean -- %f";
         smudge = "${pkgs.git-lfs}/bin/git-lfs smudge --skip -- %f";
         process = "${pkgs.git-lfs}/bin/git-lfs filter-process --skip";
         required = true;
      };

      push = { autoSetupRemote = true; };

      safe.directory = "*";

    };
  };
}
