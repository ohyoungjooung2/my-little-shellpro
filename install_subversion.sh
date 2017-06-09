#!/usr/bin/env bash
SVN="subversion"
. ./check_distro.sh
#P=`check_distro`
#echo $P
install_apache_svn(){
 echo "Do you want to install apache-svn based installation also?"
 read ASVN_ANSWER
 if [[ $ASVN_ANSWER =~ (Y|y) ]]
 then
   sudo $P -y install apache2 libapache2-svn
 else
   echo "do nothing"
 fi
}

install_subversion(){
    if [[ ! -e  /bin/svn ]]
    then
     sudo $P -y install $SVN
    fi
}


install_subversion
install_apache_svn
