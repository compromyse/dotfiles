{ home, pkgs, ... }:

{
  home.packages = with pkgs; [
    sway
    autotiling-rs
  ];
}
