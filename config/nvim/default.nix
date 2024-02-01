{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.file.".config/nvim/init.lua".source = ./init.lua;
  home.file.".config/nvim/lua" = {
    source = ./lua;
    recursive = true;
  };
}
