PLATFORMS=('run-np' 'run-zb' 'run-za' 'run-at' 'runps' 'runpa')

alias cfat="CF_HOME=~/.cf/run-at cf"
alias cfnp="CF_HOME=~/.cf/run-np cf"
alias cfza="CF_HOME=~/.cf/run-za cf"
alias cfzb="CF_HOME=~/.cf/run-zb cf"
alias cfps="CF_HOME=~/.cf/runps cf"
alias cfpa="CF_HOME=~/.cf/runpa cf"
alias cfgnp="CF_HOME=~/.cf/gnp cf"

function cf-login() {
  CF_USERNAME=$(security find-generic-password -a ${USER} -s CF_USER -w )
  CF_PASSWORD=$(security find-generic-password -a ${USER} -s CF_PASS -w )


  if [[ $CF_USERNAME == '' ]]; then
    printf "user > "
    read CF_USERNAME
    printf "pass > "
    read -s CF_PASSWORD

    printf "\nwould you like to add your cf cli credentials to the keychain? (y/n) "
    read CONSENT

    if [[ $CONSENT == 'y' ]]; then
      security add-generic-password -a ${USER} -s CF_USER -w $CF_USERNAME
      security add-generic-password -a ${USER} -s CF_PASS -w $CF_PASSWORD
    fi
  fi

  for p in $PLATFORMS; do
    echo $p
    mkdir -p ~/.cf/$p
    CF_HOME=~/.cf/$p cf api "api.$p.homedepot.com"
    CF_HOME=~/.cf/$p cf auth $CF_USERNAME $CF_PASSWORD
  done
}

function cf-all-target() {
  for p in ${PLATFORMS[*]}; do
    CF_HOME=~/.cf/$p cf target $@
  done
}

. ~/dotfiles/zsh/pcf/search-user.sh

export -f cf-all-target cf-login > /dev/null
