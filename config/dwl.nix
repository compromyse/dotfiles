{ pkgs, home, ... }:

{
  home.packages = home.packages ++ [ tmux ]
}
