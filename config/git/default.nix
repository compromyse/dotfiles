{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    userName = "Raghuram Subramani";
    userEmail = "raghus2247@gmail.com";
    extraConfig = {
      "filter \"lfs\"" = {
         clean = "${pkgs.git-lfs}/bin/git-lfs clean -- %f";
         smudge = "${pkgs.git-lfs}/bin/git-lfs smudge --skip -- %f";
         process = "${pkgs.git-lfs}/bin/git-lfs filter-process --skip";
         required = true;
      };
      push = { autoSetupRemote = true; };
    };
  };
}
