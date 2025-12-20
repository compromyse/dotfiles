{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    polkit_gnome

    libnotify
    libappindicator

    inotify-tools

    wbg

    wirelesstools
    pamixer
    brightnessctl
    networkmanagerapplet
    grim
    slurp
    swappy

    # sway-launcher-desktop
    bemenu
  ];

  xdg.portal = {
      enable = true;
      wlr.enable = true;
      wlr.settings.screencast.chooser_type = "dmenu";
      wlr.settings.screencast.chooser_cmd = "${(pkgs.writeShellScriptBin "bemenu" ''
        ${pkgs.bemenu}/bin/bemenu -b --fn 'UbuntuMono Nerd Font Mono' --line-height 40 --tb '#9b9b9bff' --tf '#0f1212ff' --fb '#0f1212ff' --ff '#9b9b9bff' --cb '#0f1212ff' --cf '#9b9b9bff' --nf '#9b9b9bff' --nb '#0f1212ff' --hb '#9b9b9bff' --hf '#0f1212ff' --ab '#0f1212ff' --af '#9b9b9bff'
      '')}/bin/bemenu";

      extraPortals = [ pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk ];
      config.common.default = "wlr";
  };

  environment.variables = {
    XCURSOR_SIZE = "16";
    WLR_DRM_DEVICES = "/dev/dri/card1";
  };

  services.dbus.enable = true;
}
