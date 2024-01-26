{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "OwO";
  networking.networkmanager.enable = true;

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

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  /* nixpkgs.overlays = [
    (self: super: {
       waybar = super.waybar.overrideAttrs (oldAttrs: {
         src = super.fetchFromGitHub {
           owner = "Alexays";
           repo = "waybar";
           rev = "e46f66b4687eb807b6fc9c6714e52c52d0885926";
           hash = "sha256-bNzLLkkhH1MZmBneP3PH3xkED0hDWXyiaMqNWF2ilII=";
         };
       });
    })
  ]; */

  users.users.compromyse = {
    isNormalUser = true;
    extraGroups = [ "wheel" "storage" "libvirtd" ];
    packages = with pkgs; [
      neofetch
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git

    polkit_gnome

    waybar
    fuzzel
    dunst
    hyprpaper
    greetd.tuigreet
    greetd.greetd

    terminator
    firefox
    spotify
    virt-manager

    pavucontrol
    blueman

    libnotify
    libappindicator

    materia-theme
    papirus-icon-theme
    capitaine-cursors
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

  system.copySystemConfiguration = true;

  system.stateVersion = "unstable";
}

