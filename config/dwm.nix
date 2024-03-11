{ pkgs, home, fetchFromGitHub, ... }:

{
  home.packages = with pkgs; [
    feh
    picom
    wmname
    xss-lock
    xsecurelock
    networkmanagerapplet
  ];
}
