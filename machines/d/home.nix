{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "docker";
    homeDirectory = "/home/docker";
  };

  home.packages = with pkgs; [
    wget

    tmux
    fzf
    fd
    ripgrep

    unzip
    zip

    ccls
    nodePackages.pyright
    git-lfs
  ];

  programs.bash.initExtra = ''
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
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
