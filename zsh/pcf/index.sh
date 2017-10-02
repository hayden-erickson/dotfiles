function encodePlatformLCP () {
  if [[ $1 == "ps" || $a == "pa" ]]
  then
    echo $1
  fi
  echo "-$1"
}

function encodeOpsManLCP() {
  if [[ $1 == "za" || $1 == "zb" ]]; then; 
    echo "-pr-$1"
    return
  fi
  echo "-$1"
}

function cf-login() {
  url="api.run$(encodePlatformLCP $1).homedepot.com"
  CF_HOME=~/.cf/$1 cf login -a $url -u hre6345
}

function pci-ssh() {
  echo "============ use RSA token as password ============"
  ssh hre6345@ubuntu@pcfopsmanager-pr-pci-$1.homedepot.com@pimssh.homedepot.com
}

export -f cf-login bosh-ssh > /dev/null
