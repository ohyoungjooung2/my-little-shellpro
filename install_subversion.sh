#!/usr/bin/env bash
SVN="subversion"
. ./check_distro.sh
#P=`check_distro`
#echo $P
install_subversion(){
    sudo $P -y install $SVN
}

install_subversion
