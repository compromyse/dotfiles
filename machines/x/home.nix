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

    cinnamon.nemo
    mate.eom

    spotify
    firefox

    obs-studio

    pavucontrol
    blueman
    brillo

    wbg
  ];

  imports = (map (path: ../../config/${path}) [
    "themes.nix"
    "dotfiles.nix"
    "git"
    "nvim"
    "alacritty"
    "dunst"
    "dwl.nix"
    "way-displays"
    "bash.nix"
    "fuzzel"
    "waybar"
  ]);

  home.stateVersion = "23.11";
}
