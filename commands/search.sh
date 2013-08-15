#! /usr/bin/env bash

require 'lib/console.sh'
require 'lib/fail.sh'
require 'lib/help.sh'
require 'lib/bashum/remote.sh'

search_usage() {
	echo "$bashum_cmd search <package> [options]"
}

search_help() {
	bold 'USAGE'
	echo 
	printf "\t"; search_usage
	echo


	bold 'DESCRIPTION'
	printf '%s' '
	Searches the remote repository for bashums to install.

'

	bold 'OPTIONS'
	printf '%s' '
	-None 

'
}

search() {
	if help? "$@" 
	then
		search_help "$@"
		exit $?
	fi

	if ! command -v git &> /dev/null
	then
		fail "git is required for searching the remote repo."
	fi

	if [[ -z "$1" ]]
	then
		error "Must provide a search expression."
		echo 

		echo -n 'USAGE: '; search_usage 
		exit 1
	fi

	remote_repos_ensure_all 

	local bashums=( $(remote_bashums_search $1) )
	for bashum in ${bashums[@]}
	do
		declare local name
		declare local version

		name=$(remote_bashum_get_name $bashum) || 
			name=$bashum

		version=$(remote_bashum_get_version $bashum) || 
			version=""

		printf '%-30s[%s]\n' "$name" "$version"
	done
}
