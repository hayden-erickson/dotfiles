#!/bin/bash
alias cmc='cmd /c'

function tk () {
	for arg in $@; do
		taskkill /IM "${arg}" 2>/dev/null;
		taskkill /F /IM "${arg}" 2>/dev/null;
		taskkill /IM "${arg}.exe" 2>/dev/null;
		taskkill /F /IM "${arg}.exe" 2>/dev/null;
	done;
}

alias ls="ls -A --color=auto"
alias rebash="source ~/.bash_profile"
alias path='echo -e ${PATH//:/\\n}'
alias more='less'
alias grep='grep --color=auto'


alias apt-get='apt-cyg'
alias scr='screen -h 1000'
alias scrls='screen -ls'
alias scrStart='screen -dRR'

alias opsman-np='ssh ubuntu@pcfopsmanager-np.homedepot.com'

alias ssh_nimbus='ssh root@ld0124.homedepot.com'


# explorer
alias e="open_explorer"
function open_explorer {
	local loc="$1"
	if [ $# -eq 0 ]; then
		if [[ ! -t 0 ]]; then
			loc=$(cat)
		fi
	fi
	if [[ -f "${loc}" ]]; then
		# file
		loc=$(dirname "${loc}")
	fi
	if [[ ! -d "${loc}" ]]; then
		# not a directory
		loc="."
	fi
	# echo "FINAL: ${loc}"
	$(cd "${loc}" && explorer .)
}


# Git shortcuts
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias glg='git log --decorate --graph --oneline' # git log graph
alias gs='git status'
alias gss='git status --short'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdf='git diff-files --name-only'
alias g='git'

alias cfat='cmd /c cf login -a api.run-at.homedepot.com -u hre6345 -p "zxasqw12ZXASQW!@" --skip-ssl-validation'
alias cfnp='cmd /c cf login -a api.run-np.homedepot.com -u hre6345 -p "zxasqw12ZXASQW!@" --skip-ssl-validation'
alias cfpr='cmd /c cf login -a api.run.homedepot.com -u hxe8629    -p "zxasqw12ZXASQW!@" --skip-ssl-validation'
