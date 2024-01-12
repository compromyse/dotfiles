sessionizer() {
  DIR=$(fdfind --type d --strip-cwd-prefix -L -H | fzf)
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

bind '"\C-f": "sessionizer\n"'
bind '"\C-F": "sessionizer -cd\n"'
