{ pkgs, home, fetchFromGitHub, ... }:

{
  home.packages = [ pkgs.dwl ];
}
