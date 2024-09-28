{ home, pkgs, ... }:

{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;

    theme = { name = "Everforest-Dark-BL-LB"; package = pkgs.everforest-gtk-theme; };
    iconTheme = { name = "Papirus-Dark"; package = pkgs.papirus-icon-theme; };

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
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };
}
