#!/bin/zsh

export EDITOR=nvim
export VISUAL=vi

set -o vi

export TMPDIR=/tmp
export TMUX_TMPDIR=~/.tmux_tmp

ssh-add ~/.ssh/id_rsa > /dev/null


export SPACESHIP_PROMPT_ORDER=( time dir git venv exec_time line_sep vi_mode jobs exit_code char )

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



BACKEND_ROOT=/home/ubuntu/co/backend


testPatternForPackage() {
 go test -list Test $1 | fzf
}

goTP() {
  testPattern="^($(testPatternForPackage $1))$" && \
  ag -U -l "$testPattern" | entr -c -r go test $1 -run "$testPattern"
}

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"


