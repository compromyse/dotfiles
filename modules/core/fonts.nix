{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "UbuntuMono" ]; })
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
  ];
}
