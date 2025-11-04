{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.ubuntu-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
  ];
}
