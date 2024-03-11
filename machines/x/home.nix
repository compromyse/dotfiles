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
    imv

    spotify
    firefox
    google-chrome

    obs-studio

    pavucontrol
    brightnessctl
    pamixer

    wbg

    sway-launcher-desktop

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
    "dwm.nix"
    "rofi"
    "dunst"
  ]);

  home.stateVersion = "23.11";
}
