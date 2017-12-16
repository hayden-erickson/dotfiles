export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
export PATH=$(yarn global bin):$PATH
export TMPDIR=/tmp
export ANDROID_HOME=~/Library/Android/sdk/
export ANT_HOME=/opt/ant
export PATH=$PATH:$ANT_HOME/bin

ssh-add ~/.ssh/id_rsa > /dev/null

export DEFAULT_USER=haydenerickson

export DRONE_SERVER="https://drone.apps-np.homedepot.com"
export DRONE_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZXh0IjoiaHJlNjM0NSIsInR5cGUiOiJ1c2VyIn0.SX2tT6hlzu6NUY1LP5o5FZVAEpjRs6oxCORPdIck3UI"

bindkey -v

source ~/dotfiles/zsh/.shell_prompt.sh

ptop() {
  # pgrep $1 find pid of first argument
  # sed -n 1p print only first line of result
  # top -pid $(...) show stats on specified pid
  top -pid $(pgrep $1 | sed -n 1p)
}

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
