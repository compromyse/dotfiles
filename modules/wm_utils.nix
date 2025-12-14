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

    sway-launcher-desktop
    bemenu
  ];

  # xdg.portal = {
  #     enable = true;
  #     extraPortals = [ pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal ];
  #     config.common.default = "wlr";
  # };

  xdg.portal.enable = true;
  xdg.portal.config.common.default = "wlr";
  xdg.portal.wlr = {
    enable = true;
    settings.screencast.chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -o";
  };

  environment.variables = {
    XCURSOR_SIZE = "16";
    WLR_DRM_DEVICES = "/dev/dri/card1";
  };

  services.dbus.enable = true;
}
