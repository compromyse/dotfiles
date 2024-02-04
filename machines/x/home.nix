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

    cinnamon.nemo
    mate.eom

    spotify
    firefox
    google-chrome

    obs-studio

    pavucontrol
    blueman
    brillo

    wbg

    ccls
    nodePackages.pyright
  ];

  imports = (map (path: ../../config/${path}) [
    "themes.nix"
    "dotfiles.nix"
    "git"
    "nvim"
    "alacritty"
    "dunst"
    "swaylock"
    "dwl.nix"
    "way-displays"
    "bash.nix"
    "fuzzel"
    "waybar"
  ]);

  home.stateVersion = "23.11";
}
