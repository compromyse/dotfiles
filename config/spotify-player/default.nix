{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    spotify-player
  ];

  home.file.".config/spotify-player/theme.toml".source = ./theme.toml;
  home.file.".config/spotify-player/app.toml".source = ./app.toml;
}
