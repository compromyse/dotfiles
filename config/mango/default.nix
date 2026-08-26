{ home, lib, ... }:

{
  wayland.windowManager.mango = {
    enable = true;
    extraConfig = builtins.readFile ./mango.conf;
    autostart_sh = ''
      wbg -s /config/dist/windows.jpg &
      waybar &
      way-displays &
      swayidle before-sleep swaylock lock swaylock &
      dunst &
    '';
  };
}
