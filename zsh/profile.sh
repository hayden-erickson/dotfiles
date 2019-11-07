#!/bin/zsh

export GOPATH=~/go
export TMPDIR=/tmp
export TMUX_TMPDIR=~/.tmux_tmp

ssh-add ~/.ssh/id_rsa > /dev/null

export DEFAULT_USER=haydenerickson

export PATH=$PATH:/Users/haydenerickson/miniconda3/bin:/usr/local/bin

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

testsInFile() {
  cat $1 | \
    grep 'func Test' | \
    awk '{print $2}' | \
    sed 's/(t//g' | \
    paste -s -d '|' - | \
    sed 's/\(.*\)/^(\1)$/g'
}

hasGitCommit() {
   if git merge-base --is-ancestor $1 $2
  then
    echo "true"
  else
    echo "false"
  fi
}

getHash() {
  git log --oneline --graph | fzf | awk '{print $2}'
}

compareCommits() {
  git diff `getHash` `getHash`
}

notify() {
  osascript -e "$(echo 'display notification "'$1'"')"
}

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

export FUNCTIONS=$(declare -pf)

