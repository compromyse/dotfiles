{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "vagrant";
    homeDirectory = "/home/vagrant";
  };

  home.packages = with pkgs; [
    wget

    tmux
    fzf
    fd
    ripgrep

    unzip
    zip

    ccls
    nodePackages.pyright
    git-lfs
  ];

  imports = (map (path: ../../config/${path}) [
    "bash.nix"
    "dotfiles.nix"
    "git"
    "nvim"
  ]);

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
