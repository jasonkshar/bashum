#! /usr/bin/env bash

export bashum_home=${bashum_home:-$HOME/.bashum}
export bashum_repo=${bashum_repo:-$HOME/.bashum_repo}
export bashum_path=${bashum_path:-$bashum_home:$bashum_repo/packages}
export bashum_project_files=${bashum_project_files:-"bin:lib:env:project.sh"}

env_usage() {
	echo "$bashum_cmd env [options]"
}

env_help() {
	bold 'USAGE'
	echo
	printf "\t"; env_usage
	echo


	bold 'DESCRIPTION'
	printf '%s' '
	Prints all the standard bashum environment entries.
'

	bold 'OPTIONS'
	printf '%s' '
	-None

'
}

env() {
	if help? $@
	then
		env_help $@
		exit $?
	fi

	info "Environment entries:"
	echo 

	local entries=( \
		bashum_home \
		bashum_repo \
		bashum_path \
		bashum_project_files \
	)

	for entry in "${entries[@]}"
	do
		printf '\t%s: %s\n' "$entry" "$(eval "echo \$$entry")"
	done
}
