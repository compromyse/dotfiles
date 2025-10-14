{ inputs, pkgs, ... }:

{
  home = {
    username = "compromyse";
    homeDirectory = "/home/compromyse";
  };

  home.packages = with pkgs; [
    tmux
    fzf
    fd
    ripgrep
    jq

    unzip
    zip
  ];

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    bash.enable = true;
  };

  imports = (map (path: ../../config/${path}) [
    "bash.nix"
    "dotfiles.nix"
    "git"
    "nvim"
  ]);

  home.stateVersion = "23.11";
}
