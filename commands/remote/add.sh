#! /usr/bin/env bash

require 'lib/bashum/cli/console.sh'
require 'lib/bashum/cli/options.sh'
require 'lib/bashum/lang/fail.sh'
require 'lib/bashum/remote.sh'

remote_add_usage() {
	echo "$bashum_cmd remote add <url> [options]"
}

remote_add_help() {
	bold 'USAGE'
	echo 
	printf "\t"; remote_add_usage
	echo


	bold 'DESCRIPTION'
	printf '%s' '
	Adds a remote repository to include when searching and installing

'

	bold 'OPTIONS'
	printf '%s' '
	-None

'
}

remote_add() {
	if options_is_help "$@" 
	then
		remote_add_help "$@"
		exit $?
	fi

	if (( $# != 1 ))
	then
		error "Must provide a repo url"
		echo 

		echo -n 'USAGE: '; remote_remove_usage 
		exit 1
	fi

	remote_repo_urls_add $1
}
