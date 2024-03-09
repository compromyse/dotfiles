{ pkgs, ... }:

let
  tlauncher = (pkgs.callPackage ../../packages/tlauncher.nix {});
in {
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "compromyse";
    homeDirectory = "/home/compromyse";
  };

  home.packages =with pkgs; [
    wget

    tmux
    fzf
    fd
    ripgrep

    unzip
    zip

    cinnamon.nemo
    mate.eom

    spotify
    firefox
    google-chrome

    obs-studio

    pavucontrol
    brillo
    playerctl
    pamixer

    wbg

    kcalc

    ccls
    nodePackages.pyright
    git-lfs
  ] ++ [ tlauncher ];

  imports = (map (path: ../../config/${path}) [
    "themes.nix"
    "fuzzel"
    "dunst"
    "dwl.nix"
    "dotfiles.nix"
    "git"
    "nvim"
    "alacritty"
    "bash.nix"
  ]);

  home.stateVersion = "23.11";
}
