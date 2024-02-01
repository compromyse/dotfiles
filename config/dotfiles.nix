{ home, lib, ... }:

{
  home.file = {
    ".tmux.conf".source = ./.tmux.conf;
    ".fdignore".source = ./.fdignore;
  };
}
