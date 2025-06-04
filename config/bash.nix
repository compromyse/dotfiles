{
  programs.bash = {
    enable = true;
    initExtra= ''
      export PS1='\[\[\e[38;5;254m\]\w \[\033[0m\]> '

      bind "set completion-ignore-case on"

      sessionizer() {
        DIR=$(fd . /home/compromyse --type d -L -d 3 | fzf)
        SESSION_NAME="$DIR_$(date +%M%S)"

        if [ -n "$DIR" ]
        then
          cd $DIR
        fi
      }

      if [[ $- != *i* ]]
      then
        sessionizer
      fi

      bind '"\C-f": "sessionizer\n"'

      alias poof="rm $HOME/.ssh/known_hosts*"

      if [ -f $HOME/.custom_bashrc ]; then
        source $HOME/.custom_bashrc
      fi
    '';
  };
}
