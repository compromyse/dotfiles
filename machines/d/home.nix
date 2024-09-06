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

    git-lfs
  ];

  programs.bash.initExtra = ''
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
    alias ls="ls --color=auto"
  '';

  imports = (map (path: ../../config/${path}) [
    "bash.nix"
    "dotfiles.nix"
    "git"
    "nvim"
  ]);

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
