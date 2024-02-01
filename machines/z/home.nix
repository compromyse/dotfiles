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

    # spotify
    # firefox

    # obs-studio

    pavucontrol
    blueman
    brillo
  ];

  imports = (map (path: ../../config/${path}) [
    "themes.nix"
    "dotfiles.nix"
    "git"
    "nvim"
    "alacritty"
    "dwl.nix"
    "fuzzel"
  ]);

  home.stateVersion = "23.11";
}
