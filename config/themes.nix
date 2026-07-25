{ home, pkgs, config, ... }:

{
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;

    # theme = { name = "Everforest-Dark-BL-LB"; package = pkgs.everforest-gtk-theme; };
    theme = { name = "adw-gtk3-dark"; package = pkgs.adw-gtk3; };
    iconTheme = { name = "Papirus-Dark"; package = pkgs.papirus-icon-theme; };
    gtk4.theme = config.gtk.theme;

    font = { name = "UbuntuMono Nerd Font Mono"; };

    gtk3.extraConfig = {
      gtk-decoration-layout = "appmenu:none";
    };
    
    gtk4.extraConfig = {
      gtk-decoration-layout = "appmenu:none";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-dark";
  };
}
