#! /usr/bin/env bash

require 'lib/bashum/cli/console.sh'
require 'lib/bashum/lang/fail.sh'

project_file_api() {
	name() {
		:
	}

	version() {
		:
	}

	author() {
		:
	}

	email() {
		:
	}

	description() {
		:
	}

	file() {
		:
	}

	depends() {
		:
	}

	release_repo() {
		:
	}

	release_site_repo() {
		:
	}

	snapshot_repo() {
		:
	}

	snapshot_site_repo() {
		:
	}
    
    
}

project_file_api_unset() {
	unset -f name
	unset -f version
	unset -f author 
	unset -f email 
	unset -f description
	unset -f file
	unset -f depends
	unset -f release_repo
	unset -f snapshot_repo
}

project_file_get_name() {
	if (( $# != 1 ))
	then
		fail 'usage: project_file_get_name <file>'
	fi

	if [[  ! -f "$1" ]]
	then
		fail "Input [$1] is not a file."
	fi

	project_file_api
	
	declare local name 
	name() {
		if (( $# != 1 ))
		then
			fail "Usage: name <name>"
		fi

		name=$1
	}

	source $1
	project_file_api_unset

	if [[ -z $name ]]
	then
		fail "Project file is missing a name [$1]"
	fi

	echo $name

}

project_file_get_author() {
	if (( $# != 1 ))
	then
		fail 'usage: project_file_get_author <file>'
	fi

	if [[  ! -f "$1" ]]
	then
		fail "Input [$1] is not a file."
	fi

	project_file_api
	
	declare local author 
	author() {
		if (( $# != 1 ))
		then
			fail "Usage: author <author>"
		fi

		author=$1
	}

	source $1
	project_file_api_unset

    echo $author
}

project_file_get_email() {
	if (( $# != 1 ))
	then
		fail 'usage: project_file_get_email <file>'
	fi

	if [[  ! -f "$1" ]]
	then
		fail "Input [$1] is not a file."
	fi

	project_file_api
	
	declare local email 
	email() {
		if (( $# != 1 ))
		then
			fail "Usage: email <email>"
		fi

		email=$1
	}

	source $1
	project_file_api_unset
    
    echo $email
}

project_file_get_description() {
	if (( $# != 1 ))
	then
		fail 'usage: project_file_get_description <file>'
	fi

	if [[  ! -f "$1" ]]
	then
		fail "Input [$1] is not a file."
	fi

	project_file_api
	
	declare local description 
	description() {
		if (( $# != 1 ))
		then
			fail "Usage: description <description>"
		fi
        
		description=$1
	}

	source $1
	project_file_api_unset

    echo $description
}

project_file_get_version() {
	if (( $# != 1 ))
	then
		fail 'usage: project_file_get_version <file>'
	fi

	if [[  ! -f "$1" ]]
	then
		fail "Input [$1] is not a file."
	fi

	project_file_api

	declare local version 
	version() {
		if (( $# != 1 ))
		then
			fail "Usage: version <version>"
		fi

		version=$1
	}

	source $1
	project_file_api_unset

	if [[ -z $version ]]
	then
		fail "Project file is missing a version [$1]"
	fi

	echo $version
}

project_file_get_globs() {
	if (( $# != 1 ))
	then
		fail 'usage: project_file_get_globs <file>'
	fi

	if [[  ! -f "$1" ]]
	then
		fail "Input [$1] is not a file."
	fi

	project_file_api
	file() {
		if (( $# != 1 ))
		then
			fail "Usage: file <glob>"
		fi
		
		echo "$1"
	}

	source $1
	project_file_api_unset
}

project_file_get_dependencies() {
	if (( $# != 1 ))
	then
		fail 'usage: project_file_get_name <file>'
	fi

	if [[  ! -f "$1" ]]
	then
		fail "Input [$1] is not a file."
	fi

	project_file_api
	depends() {
		if (( $# < 1 )) || (( $# > 2 )) 
		then
			fail "Usage: depends <project> [<version>]"
		fi

		if [[ -z $1 ]]
		then
			fail "Must provide at least a name"
		fi

		echo "$1:$2"
	}

	source $1
	project_file_api_unset
}

# project_file_get_repo <file>
#
# returns the appropriate repo for the given version
# or none, if no repo is available.
project_file_get_repo() {
	if (( $# != 1 ))
	then
		fail 'usage: project_file_get_repo <file>'
	fi

	if [[  ! -f "$1" ]]
	then
		fail "Input [$1] is not a file."
	fi

	project_file_api

	declare local release_repo
	release_repo() {
		if (( $# != 1 ))
		then
			fail "Usage: release_repo <url>"
		fi

		release_repo=$1
	}

	declare local snapshot_repo
	snapshot_repo() {
		if (( $# != 1 ))
		then
			fail "Usage: snapshot_repo <url>"
		fi

		snapshot_repo=$1
	}

	source $1
	project_file_api_unset


	local version=$(project_file_get_version $1)
	if [[ $version == *SNAPSHOT* ]]
	then
		if [[ -n $snapshot_repo ]]
		then
			echo $snapshot_repo
			return 0
		fi
	fi

	if [[ -n $release_repo ]]
	then
		echo $release_repo
	fi
}

# project_file_get_site_repo <file>
#
# returns the appropriate site repo for the given version
# or none, if no repo is available.
project_file_get_site_repo() {
	if (( $# != 1 ))
	then
		fail 'usage: project_file_get_repo <file>'
	fi

	if [[  ! -f "$1" ]]
	then
		fail "Input [$1] is not a file."
	fi

	project_file_api

	declare local release_repo
	release_site_repo() {
		if (( $# != 1 ))
		then
			fail "Usage: site_release_repo <url>"
		fi

		release_repo=$1
	}

	declare local snapshot_repo
    snapshot_site_repo() {
		if (( $# != 1 ))
		then
			fail "Usage: site_snapshot_repo <url>"
		fi

		snapshot_repo=$1
	}

	source $1
	project_file_api_unset


	local version=$(project_file_get_version $1)
	if [[ $version == *SNAPSHOT* ]]
	then
		if [[ -n $snapshot_repo ]]
		then
			echo $snapshot_repo
			return 0
		fi
	fi

	if [[ -n $release_repo ]]
	then
		echo $release_repo
	fi
}

project_file_print() {
	if (( $# != 1 ))
	then
		fail 'usage: project_file_print <file>'
	fi

	if [[  ! -f "$1" ]]
	then
		fail "Project file [$1] does not exist"
	fi
	
	project_file_api

	local name=""
	name() {
		if (( $# != 1 ))
		then
			fail "Usage: name <name>"
		fi

		name=$1
	}

	local version=""
	version() {
		if (( $# != 1 ))
		then
			fail "Usage: version <version>"
		fi

		version=$1
	}

	local author=""
	author() {
		if (( $# != 1 ))
		then
			fail "Usage: author <author>"
		fi

		author=$1
	}

	local email=""
	email() {
		if (( $# != 1 ))
		then
			fail "Usage: email <email>"
		fi

		email=$1
	}

	local description=""
	description() {
		if (( $# != 1 ))
		then
			fail "Usage: description <description>"
		fi

		description=$1
	}

	local file_globs=()
	file() {
		if (( $# != 1 ))
		then
			fail "Usage: file <glob>"
		fi

		file_globs+=( "$1" )
	}

	local dependencies=()
	depends() {
		if (( $# < 1 )) || (( $# > 2 )) 
		then
			fail "Usage: depends <project> [<version>]"
		fi

		if [[ -z $1 ]]
		then
			fail "Must provide at least a name"
		fi
		
		dependencies+=( "$1:$2" )
	}

	source $1
	project_file_api_unset

	# ensure that everything was set appropriately
	if [[ -z "$name" ]]
	then
		fail "Project file [$1] must provide a valid project name."
	fi

	if [[ -z "$version" ]]
	then
		fail "Project file [$1] must provide a valid project version."
	fi

	info "Name:"
	echo "    - $name" 
	echo

	info "Version:" 
	echo "    - $version"
	echo

	if [[ ! -z $author ]]
	then
		info "Author:"
		echo "    - $author"
		echo
	fi

	if [[ ! -z $email ]]
	then
		info "Email:"
		echo "    - $email"
		echo
	fi

	if [[ ! -z $description ]]
	then
		info "Description:"
		echo "    - $description"
		echo
	fi

	## print the executables
	#if (( ${#executables[@]} > 0 ))
	#then
		#info "Executables: " 
		#declare local file
		#for file in "${executables[@]}" 
		#do
			#echo "    - $(basename $file)"
		#done
		#echo 
	#fi

	## print the library files
	#if (( ${#libs[@]} > 0 ))
	#then
		#info "Libraries: " 
		#declare local file
		#for file in "${libs[@]}" 
		#do
			#echo "    - ${file##*$name}"
		#done
		#echo 
	#fi

	if (( "${#file_globs}" > 0 ))
	then
		info "Files:"
		declare local glob
		for glob in "${file_globs[@]}"
		do
			echo "    - $glob"
		done
		echo
	fi

	if (( "${#dependencies}" > 0 ))
	then
		info "Dependencies:"
		declare local dep
		for dep in "${dependencies[@]}"
		do
			local dep_name=${dep%%:*}
			local dep_version=${dep##*:}
			echo "    - $dep_name${dep_version:+":$dep_version"}"
		done
	fi
}

# usage: project_file_version_compare <version1> <version2>
#
# Returns one of three values:
#   0 - they are equal
#   1 - version2 is greater
#  -1 - version1 is greater
project_file_version_compare() {
	if (( $# != 2 ))
	then
		fail 'usage: project_file_version_compare <version1> <version2>'
	fi

	if [[ "$1" == "$2" ]]
	then
		echo 0; return
	fi

	local simple_one=$(echo $1 | sed 's|[-\.]SNAPSHOT.*$||')
	local simple_two=$(echo $2 | sed 's|[-\.]SNAPSHOT.*$||')

	if [[ "$simple_one" > "$simple_two" ]]
	then
		echo -1; return
	fi

	# 2 is a snapshot, 1 is a release
	if [[ "$2" == *SNAPSHOT* ]] && [[ $1 != *SNAPSHOT* ]]
	then
		echo -1; return
	fi

	# 2 is a release, 1 is a snapshot
	if [[ "$2" != *SNAPSHOT ]] && [[ $1 == *SNAPSHOT* ]]
	then
		echo 1; return
	fi

	# they're both snapshots, 1 is lexicograpically greater
	if [[ "$1" > "$2" ]]
	then
		echo -1; return
	fi
	
	# 2 is greater
	echo 1; return
}
