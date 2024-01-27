{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "OwO";
  networking.networkmanager.enable = true;

  fileSystems."/data" = {
    device = "/dev/sda";
    fsType = "ext4";
  };

  time.timeZone = "Asia/Kolkata";

  nixpkgs.config.allowUnfree = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  services.printing.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  services.xserver.libinput.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "tuigreet --time --remember --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  environment.etc."inputrc".text = pkgs.lib.mkForce (
    builtins.readFile <nixpkgs/nixos/modules/programs/bash/inputrc> + ''
      set completion-ignore-case on
    ''
  );

  users.users.compromyse = {
    isNormalUser = true;
    extraGroups = [ "wheel" "storage" "libvirtd" ];
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.compromyse = { pkgs, ... }: {
    home.packages = with pkgs; [
      wget

      tmux
      fzf
      fd
      ripgrep

      cinnamon.nemo
      mate.eom

      spotify
      firefox

      pavucontrol
      blueman
      brillo
    ];

    programs.bash = {
      enable = true;
      initExtra= ''
        export PS1="\[\e[38;5;243m\]\h \[\e[38;5;254m\]\w \[\033[0m\]> "

        sessionizer() {
          DIR=$(fd . $HOME --type d -L -H | fzf)
          SESSION_NAME="$DIR_$(date +%M%S)"

          if [ -n "$DIR" ]
          then
            if [ "$1" == "-cd" ]
            then
              cd $DIR
              return
            fi
            tmux new-session -d -c "$DIR" -s "$SESSION_NAME"
            if [ -n "$TMUX" ]
            then
              tmux switch -t "$SESSION_NAME"
            else
              tmux attach -t "$SESSION_NAME"
            fi
          fi
        }

        if [[ $- != *i* ]]
        then
          sessionizer
        fi

        bind '"\C-f": "sessionizer\n"'
        bind '"\C-F": "sessionizer -cd\n"'
      '';
    };

    programs.git = {
      enable = true;
      userName = "Raghuram Subramani";
      userEmail = "raghus2247@gmail.com";
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };


    programs.alacritty = {
      enable = true;
    };

    home.file = {
      ".tmux.conf".source = ./.tmux.conf;
      ".fdignore".source = ./.fdignore;
      ".config" = {
        source = ./config;
        recursive = true;
      };
    };

    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };

    gtk = {
      enable = true;

      theme = { name = "adw-gtk3-dark"; package = pkgs.adw-gtk3; };
      iconTheme = { name = "Papirus-Light"; package = pkgs.papirus-icon-theme; };

      font = { name = "UbuntuMono Nerd Font"; };
    };

    qt = {
      enable = true;
      platformTheme = "gtk";
      style.name = "adwaita-dark";
    };

    home.stateVersion = "23.11";
    programs.home-manager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    waybar
    tofi
    fuzzel
    dunst
    hyprpaper

    networkmanagerapplet

    greetd.tuigreet
    greetd.greetd
    polkit_gnome
    waylock

    libnotify
    libappindicator
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "UbuntuMono" ]; })
  ];

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  programs.gnupg.agent = {
    enable = true;
  };

  security.polkit.enable = true;
  security.pam.services.waylock.text = ''
    auth include login
  '';

  system.stateVersion = "23.11";
}

