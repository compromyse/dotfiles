{ pkgs, config, lib, ... }:

{
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
