GRAPHQL_Q='query space_auditors($page:Int) {
  organizations (page:$page){
    name
    managers { username }
    auditors { username }
    spaces {
      name
      auditors { username }
      developers { username }
    }
  }
}'


getPage() {
  curl $1/graphql -s \
    --data-urlencode query="$GRAPHQL_Q" \
    --data-urlencode variables="{\"page\": $2 }" \
    --get
}

getPageLength() {
  getPage $1 $2 | jq '.data.organizations | length'
}

filter() {
  echo "( map( select($1) ) )"
}

jqEquals() {
   echo ".$1 == \"$2\""
}

usernameEquals() {
  jqEquals 'username' $1
}


map() {
  FUNC=${*[1]}
  ARGS=(${*[@]:2})

  for a in $ARGS; do
    echo $($FUNC $a)
  done
}

orJoin() {
  LIST=($*)
  LIST_LEN=${#LIST[@]}
  final=''

  if [ $LIST_LEN -le 1 ]; then
    final+="$*"
  else
    for (( i = 1; i < $LIST_LEN; i++ )); do
      final+="${LIST[i]} or "
    done

    final+="${LIST[$LIST_LEN]}"
  fi

  echo $final
}

listContains() {
  echo "( .$1 | $(filter "$2") )"
}

findUserFrom() {
	QUERY=".data.organizations
		| map({
		    name,
		    auditors: $(listContains auditors $1),
		    managers: $(listContains managers $1),
		    spaces: .spaces
		    | map({
		      name,
		      auditors: $(listContains auditors $1),
		      developers: $(listContains developers $1)
		    })
		    | $( filter "( (.developers | length) + (.auditors | length) ) > 0" )
		})
		| $( filter "(.spaces | length) > 0" )
		| map({ name, auditors, managers, spaces })"

	echo $2 | jq "$QUERY"
}

FIND_USER_HELP_TEXT="find-pcf-users - search a particular foundation for a list of users

    USAGE: find-pcf-users -f cf-api.run-np.homedepot.com -u ldap1 [-u ldap2 ...]

    find-pcf-users will loop through responses from cf-api which contain all orgs
    in a foundation. For each org in a foundation the list of auditors and managers
    is searched for the provided users. Additionally, for each org every space is
    retrieved and for each space the list of auditors and developers is searched
    for the provided users. The command line tools jq and curl are required for
    this function to work properly.

    OPTIONS:
      -f 	graphql url for a foundation    	REQUIRED
      -u 	a list of users to search for		REQUIRED
      -h 	display this help message
"
find-pcf-users() {
  CF_API=''
  USERS=()

  while getopts 'hf:u:' flag; do
    case "${flag}" in
      f) CF_API=${OPTARG};;
      u) USERS+="${OPTARG}";;
      h) echo $FIND_USER_HELP_TEXT && return;;
      *) error "Unexpected option ${flag}" ;;
    esac
  done

  PAGE=1
  PAGE_LEN=$(getPageLength $CF_API $PAGE)

  USER_CONDS=()
  map usernameEquals $USERS | while read line; do USER_CONDS+=$line; done
  USER_FILTER="$(orJoin $USER_CONDS)"

  while [ $PAGE_LEN -ne 0 ]; do
    FOUND_DATA="$(findUserFrom "$USER_FILTER" "$(getPage $CF_API $PAGE)")"
    FOUND_DATA_LEN=$(echo $FOUND_DATA | jq 'length')

    if [[ $FOUND_DATA_LEN > 0 ]]; then
	    echo $FOUND_DATA
    else
	    printf '.'
    fi

    PAGE=$(expr $PAGE + 1)
    PAGE_LEN=$(getPageLength $CF_API $PAGE)
  done

  echo "\ndone"
}

export -f find-pcf-users > /dev/null
