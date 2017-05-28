#!/usr/bin/env bash
SVN="subversion"
. ./check_distro.sh
#P=`check_distro`
#echo $P
install_subversion(){
    if [[ ! -e  /bin/svn ]]
    then
     sudo $P -y install $SVN
    fi
}


install_subversion
