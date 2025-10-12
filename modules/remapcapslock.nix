{ pkgs, config, ... }:

{
  services.interception-tools =
    let
      itools = pkgs.interception-tools;
      itools-caps = (pkgs.interception-tools-plugins.caps2esc.overrideAttrs (old: {
          patches = [
            (pkgs.fetchpatch {
              url = "https://gitlab.com/interception/linux/plugins/caps2esc/-/commit/47ea8022df47b23d5d9603f9fe71b3715e954e4c.patch";
              sha256 = "sha256-lB+pDwmFWW1fpjOPC6GLpxvrs87crDCNk1s9KnfrDD4=";
            })
          ];
      }));
    in
    {
      enable = true;
      plugins = [ itools-caps ];
      # requires explicit paths: https://github.com/NixOS/nixpkgs/issues/126681
      udevmonConfig = pkgs.lib.mkDefault ''
        - JOB: "${itools}/bin/intercept -g $DEVNODE | ${itools-caps}/bin/caps2esc -m 1 | ${itools}/bin/uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
              EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
      '';
    };
}
