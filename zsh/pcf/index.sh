PLATFORMS=("run-np" "run-zb" "run-za" "run-at")

function cf-login() {
  echo "ldap> "
  read CF_USERNAME
  echo "password> "
  read -s CF_PASSWORD

  for p in ${PLATFORMS[*]}; do
    echo $p
    CF_HOME=~/.cf/$p cf login -a "api.$p.homedepot.com" -u $CF_USERNAME -p $CF_PASSWORD
  done
}

function pci-ssh() {
  echo "============ use RSA token as password ============"
  ssh hre6345@ubuntu@pcfopsmanager-pr-pci-$1.homedepot.com@pimssh.homedepot.com
}

export -f cf-login bosh-ssh > /dev/null
