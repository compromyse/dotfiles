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

    imv

    spotify
    firefox
    google-chrome

    obs-studio

    wl-clipboard

    clang-tools
    ccls
    ruff-lsp
    git-lfs

    slides
  ];

  imports = (map (path: ../../config/${path}) [
    "bash.nix"
    "dotfiles.nix"
    "git"
    "emacs"
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
