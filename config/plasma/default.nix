{ home, pkgs, ... }:

{
  home.file.".local/share/color-schemes/aura-theme-soft.colors".source = ./aura-theme-soft.colors;

  home.packages = [
    pkgs.bibata-cursors
    pkgs.papirus-icon-theme
    kdePackages.yakuake
  ];

  gtk = {
    enable = true;

    theme = { name = "Breeze"; };
    iconTheme = { name = "Papirus-Dark"; };

    font = { name = "UbuntuMono Nerd Font Mono"; };
  };

  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      colorScheme = "aura-theme-soft";
      cursor = {
        theme = "Bibata-Modern-Classic";
        size = 18;
      };
      iconTheme = "Papirus-Dark";
      wallpaper = "/config/dist/wallpaper.png";
    };

    kscreenlocker.appearance.wallpaper = "/config/dist/wallpaper.png";

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

    hotkeys.commands."launch-lg" = {
      name = "Launch Looking Glass";
      key = "Meta+G";
      command = "looking-glass-client -m 97";
    };

    kwin = {
      edgeBarrier = 0;
      cornerBarrier = false;

      titlebarButtons.left = [];
      titlebarButtons.right = [ "minimize" "maximize" "close"];

      effects.shakeCursor.enable = true;
      effects.translucency.enable = true;
      effects.wobblyWindows.enable = true;
    };

    configFile.kwinrc.MouseBindings.CommandAllKey = "Alt";

    shortcuts = {
      kwin = {
        "Window Operations Menu" = "Alt+Space";
      };
    };

    input.mice = [
      {
        /* cat /proc/bus/input/devices */
        vendorId = "06cb";
        productId = "ce81";
        name = "DLL0C55:00 06CB:CE81 Touchpad";
        middleButtonEmulation = true;
        naturalScroll = true;
      }
    ];

    panels = [
      {
        location = "bottom";
        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General = {
                alphaSort = true;
              };
            };
          }

          {
            iconTasks = {
              launchers = [];
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
