{ home, pkgs, ... }:

{
  # home.file.".local/share/color-schemes/aura-theme-soft.colors".source = ./aura-theme-soft.colors;
  home.file.".local/share/color-schemes/win98dark.colors".source = ./win98dark.colors;
  home.file.".local/share/icons/Memphis98".source = ./Memphis98;
  home.file.".local/share/plasma/desktoptheme/memphis-translucent".source = ./memphis-translucent;

  home.packages = [
    pkgs.bibata-cursors
    pkgs.papirus-icon-theme
    pkgs.wl-clipboard
    pkgs.kdePackages.yakuake
  ];

  gtk = {
    enable = true;

    theme = { name = "Breeze"; };
    # iconTheme = { name = "Papirus-Dark"; };
    iconTheme = { name = "Memphis98"; };

    font = { name = "UbuntuMono Nerd Font Mono"; };
  };

  programs.plasma = {
    enable = true;

    configFile = {
      "kdeglobals"."KDE"."AnimationDurationFactor" = 0;
      "kwinrc"."Globals"."AnimationsEnabled" = false;
    };

    workspace = {
      # lookAndFeel = "org.kde.breezedark.desktop";
      # colorScheme = "aura-theme-soft";
      colorScheme = "Win98-Dark";
      cursor = {
        theme = "Bibata-Modern-Classic";
        size = 16;
      };
      # iconTheme = "Papirus-Dark";
      iconTheme = "Memphis98";
      wallpaper = "/config/dist/retro.jpg";
      theme = "memphis-translucent";
      widgetStyle = "Windows";
      splashScreen.theme = "None";
    };

    kscreenlocker.appearance.wallpaper = "/config/dist/retro.jpg";

    fonts = {
      general = {
        family = "UbuntuMono Nerd Font";
        pointSize = 10;
      };
      
      fixedWidth = {
        family = "UbuntuMono Nerd Font Mono";
        pointSize = 10;
      };
    };

    hotkeys.commands."launch-alacritty" = {
      name = "Launch Alacritty";
      key = "Ctrl+Alt+T";
      command = "alacritty";
    };

    /* hotkeys.commands."launch-lg" = {
      name = "Launch Looking Glass";
      key = "Meta+G";
      command = "looking-glass-client -m 97";
    }; */

    hotkeys.commands."launch-krunner" = {
      name = "Launch KRunner";
      key = "Meta+Space";
      command = "krunner";
    };

    kwin = {
      edgeBarrier = 0;
      cornerBarrier = false;

      titlebarButtons.left = [];
      titlebarButtons.right = [ "minimize" "maximize" "close"];

      effects.shakeCursor.enable = true;
      effects.translucency.enable = false;
      effects.wobblyWindows.enable = false;
    };

    configFile.kwinrc.MouseBindings.CommandAllKey = "Alt";
    configFile.kwinrc.TabBox.LayoutName = "compact";

    shortcuts = {
      kwin = {
        "Window Operations Menu" = "Alt+Space";
      };
    };

    /* cat /proc/bus/input/devices */
    input.mice = [
      {
        vendorId = "06cb";
        productId = "ce81";
        name = "DLL0C55:00 06CB:CE81 Touchpad";
        middleButtonEmulation = true;
        naturalScroll = true;
      }

      {
        vendorId = "06cb";
        productId = "ce67";
        name = "SYNA8022:00 06CB:CE67 Touchpad";
        middleButtonEmulation = true;
        naturalScroll = true;
      }
    ];

    panels = [
      {
        location = "bottom";
        height = 32;
        widgets = [
          {
            name = "org.kde.plasma.kicker";
            config = {
              General = {
                alphaSort = true;
              };
            };
          }

          {
            name = "org.kde.plasma.taskmanager";
            config = {
              General = {
                launchers = [];
                alphaSort = true;
              };
            };
          }

          "org.kde.plasma.marginsseparator"

          {
            systemTray.items = {
              shown = [
                "org.kde.plasma.battery"
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.volume"
              ];
            };
          }
          {
            digitalClock = {
              time.format = "24h";
            };
          }
        ];
      }
    ];
  };
}
