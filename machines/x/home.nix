{ inputs, pkgs, ... }:

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

    imv

    discord
    firefox
    google-chrome

    filezilla
    pcmanfm

    obs-studio

    wl-clipboard

    git-lfs
    slides

    ollama
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

    # "qtile"
    # "dwl.nix"
    # "themes.nix"
    # "way-displays"
    # "swaylock"
    # "dunst"

    "plasma"

    "alacritty"
    "spotify-player"
  ]);

  home.stateVersion = "23.11";
}
