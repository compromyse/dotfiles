{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "compromyse";
    homeDirectory = "/home/compromyse";
  };

  home.packages = with pkgs; [
    wget

    tmux
    fzf
    fd
    ripgrep

    unzip
    zip

    # cinnamon.nemo
    # mate.eom

    spotify
    firefox
    google-chrome

    obs-studio

    # pavucontrol
    # blueman
    # brillo

    # wbg

    kcalc

    ccls
    rubocop
    nodePackages.pyright
    git-lfs
  ];

  imports = (map (path: ../../config/${path}) [
    # "themes.nix"
    "dotfiles.nix"
    "git"
    "nvim"
    "alacritty"
    "bash.nix"
  ]);

  home.stateVersion = "23.11";
}
