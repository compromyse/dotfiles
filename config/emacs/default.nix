{ pkgs, config, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  home.file = {
    ".emacs.d/init.el".source = ./init.el;
    ".emacs.d/modeline".source = ./modeline;
  };
}
