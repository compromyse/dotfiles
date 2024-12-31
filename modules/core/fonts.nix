{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    # nerd-fonts.ubuntu-mono
    (nerdfonts.override { fonts = [ "UbuntuMono" ]; })
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
  ];
}
