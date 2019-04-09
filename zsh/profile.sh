export GOPATH=~/go
export TMPDIR=/tmp

ssh-add ~/.ssh/id_rsa > /dev/null

export DEFAULT_USER=haydenerickson

tm() {
  if [[ $1 == "rm" ]]; then
    rm $TMUX_TMPDIR/$2
    return
  fi

  if [[ $1 == "ls" ]]; then
    ls $TMUX_TMPDIR
    return
  fi

  tmux -2 -S $TMUX_TMPDIR/$1 at

  if [[ $? != 0 ]]; then
    tmux -2 -S $TMUX_TMPDIR/$1
  fi
}

export FUNCTIONS=$(declare -pf)
