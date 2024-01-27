{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

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

      obs-studio

      pavucontrol
      blueman
      brillo
    ];

    programs.bash = {
      enable = true;
      initExtra= ''
        export PS1="\[\e[38;5;243m\]\h \[\e[38;5;254m\]\w \[\033[0m\]> "

        if [[ -n "$IN_NIX_SHELL" ]]; then
          export PS1="\[\e[38;5;242m\](dev) $PS1"
        fi

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
  };

  environment.etc."inputrc".text = pkgs.lib.mkForce (
    builtins.readFile <nixpkgs/nixos/modules/programs/bash/inputrc> + ''
      set completion-ignore-case on
    ''
  );

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
