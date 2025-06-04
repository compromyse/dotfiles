{ inputs, pkgs, ... }:

{
  home = {
    username = "compromyse";
    homeDirectory = "/home/compromyse";
  };

  home.packages = with pkgs; [
    wget
    aria2

    tmux
    fzf
    fd
    ripgrep

    unzip
    zip

    imv
    mpv

    firefox
    chromium
    spotify

    postman
    obsidian

    filezilla
    pcmanfm

    obs-studio

    wl-clipboard

    git-lfs
    slides

    vscode
  ];

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    bash.enable = true;
  };

  imports = (map (path: ../../config/${path}) [
    "bash.nix"
    "dotfiles.nix"
    "git"
    "emacs"
    "nvim"

    "labwc"
    # "qtile"
    # "plasma"
    # "sway"
    # "dwl.nix"
    "themes.nix"
    "way-displays"
    "swaylock"
    "dunst"

    "alacritty"
    # "spotify-player"
  ]);

  home.stateVersion = "23.11";
}
