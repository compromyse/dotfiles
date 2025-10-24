{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Raghuram Subramani";
      user.email = "raghus2247@gmail.com";

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
