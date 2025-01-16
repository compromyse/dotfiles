{ home, pkgs, ... }:

{
  home.packages = [
    pkgs.bibata-cursors
    pkgs.papirus-icon-theme
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
      cursor = {
        theme = "Bibata-Modern-Classic";
        size = 18;
      };
      iconTheme = "Papirus-Dark";
      wallpaper = "/config/dist/wallpaper.jpg";
    };

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

    kwin = {
      edgeBarrier = 0;
      cornerBarrier = false;

      titlebarButtons.left = [];
      titlebarButtons.right = [ "minimize" "maximize" "close"];

      effects.shakeCursor.enable = true;
      effects.translucency.enable = true;
      effects.wobblyWindows.enable = true;
    };

    shortcuts = {
      kwin = {
        "Window Operations Menu" = "Alt+Space";
      };
    };

    input.mice = [
      {
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
