{ home, lib, ... }:

{
  wayland.windowManager.mango = {
    enable = true;
    extraConfig = builtins.readFile ./mango.conf;
  };
}
