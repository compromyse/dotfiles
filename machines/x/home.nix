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

    imv

    spotify
    firefox
    google-chrome

    obs-studio

    wl-clipboard

    ccls
    nodePackages.pyright
    git-lfs
  ] ++ [ tlauncher ];

  imports = (map (path: ../../config/${path}) [
    "bash.nix"
    "dotfiles.nix"
    "git"
    "nvim"

    "dwl.nix"
    "themes.nix"
    "way-displays"
    "swaylock"
    "dunst"

    "alacritty"
  ]);

  home.stateVersion = "23.11";
}
