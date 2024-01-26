sessionizer() {
  DIR=$(fdfind . $HOME --type d -L -H | fzf)
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
