{
  programs.bash = {
    enable = true;
    initExtra= ''
      export PS1="\[\e[38;5;243m\]\h \[\e[38;5;254m\]\w \[\033[0m\]> "
      set -o vi

      if [[ -n "$IN_NIX_SHELL" ]]; then
        export PS1="\[\e[38;5;242m\](dev) $PS1"
      fi

      sessionizer() {
        DIR=$(fd . /data --type d -L -H | fzf)
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
      bind '"\C-a": "sessionizer -cd\n"'
    '';
  };

}
