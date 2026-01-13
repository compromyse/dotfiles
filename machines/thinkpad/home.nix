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

    librewolf
    spotify

    pcmanfm

    obs-studio

    git-lfs
    slides

    calibre
    kdePackages.okular

    protonvpn-gui
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

    "plasma"
    # "qtile"
    # "labwc"
    # "dwl.nix"
    # "sway"
    # "themes.nix"
    # "waybar"
    # "way-displays"
    # "swaylock"
    # "dunst"
    # "gnome.nix"

    "alacritty"
    # "spotify-player"
  ]);

  home.stateVersion = "23.11";
}
