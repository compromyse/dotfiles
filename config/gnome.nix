{ home, pkgs, ... }:

{
  dconf.enable = true;
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        dash-to-panel.extensionUuid
      ];
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = true;
      tap-to-click = true;
      tap-and-drag = true;
    };
    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = false;
      accel-profile = "flat";
      speed = 0.5;
    };

    "org/gnome/desktop/background" = {
      picture-uri =
        "file:///config/dist/wallpaper.png";
      picture-uri-dark =
        "file:///config/dist/wallpaper.png";
    };

    "org/gnome/desktop/interface" = {
      clock-format = "24h";
      clock-show-weekday = true;
      # enable-animations = false;
      enable-hot-corners = false;
      color-scheme = "prefer-dark";
      show-battery-percentage = true;
    };

    "org/gnome/shell/extensions/user-theme" = {
       name = "adw-gtk3-dark";
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
        dot-style-focused = "DASHES";
        dot-style-unfocused = "DASHES";
        dot-color-dominant = true;
        hot-keys = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
        switch-applications = [];
        switch-applications-backward = [];
        switch-windows = ["<Alt>Tab"];
        switch-windows-backward = ["<Shift><Alt>Tab"];
    };
  };
}
