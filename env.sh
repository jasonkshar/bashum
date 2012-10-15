# See if bashum_home has been set. If not, assume the standard location. 
export bashum_home=${bashum_home:-$HOME/.bashum}
export bashum_repo=${bashum_repo:-$HOME/.bashum_repo}

# add the root bin dir to the path
if ! echo $PATH | grep -q $bashum_home/bin
then
	PATH=$bashum_home/bin:$PATH
fi

# add the repo bin dir to the path 
if ! echo $PATH | grep -q $bashum_repo/bin
then
	PATH=$bashum_repo/bin:$PATH
fi

# source all the bashum environment files
for file in $(ls $bashum_home/env/*.sh 2>/dev/null) 
do
	if [[ -f $file ]]
	then
		source $file 
	fi
done

# source all the environment files in all the packages.
for file in $(ls $bashum_repo/packages/*/env/*.sh 2>/dev/null) 
do
	if [[ -f $file ]]
	then
		source $file 
	fi
done
