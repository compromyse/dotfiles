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
    brightnessctl
    pamixer

    wbg

    ccls
    nodePackages.pyright
    git-lfs
  ] ++ [ tlauncher ];

  imports = (map (path: ../../config/${path}) [
    "themes.nix"
    "bash.nix"
    "dotfiles.nix"
    "git"
    "nvim"
    "alacritty"
    "dwl.nix"
    "way-displays"
    "swaylock"
    "fuzzel"
    "dunst"
  ]);

  home.stateVersion = "23.11";
}
