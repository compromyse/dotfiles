{
  programs.bash = {
    enable = true;
    initExtra= ''
      function timer_start {
        timer=''${timer:-$SECONDS}
      }

      function timer_stop {
        timer_show=$(($SECONDS - $timer))
        unset timer
      }

      trap 'timer_start' DEBUG

      if [ "$PROMPT_COMMAND" == "" ]; then
        PROMPT_COMMAND="timer_stop"
      else
        PROMPT_COMMAND="$PROMPT_COMMAND; timer_stop"
      fi
      export PS1='\[\e[38;5;243m\](''${timer_show}s) \h \[\e[38;5;254m\]\w \[\033[0m\]> '

      bind "set completion-ignore-case on"

      if [[ -n "$IN_NIX_SHELL" ]]; then
        export PS1="\[\e[38;5;242m\](dev) $PS1"
      fi

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
    '';
  };
}
