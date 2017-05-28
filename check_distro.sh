#!/usr/bin/env bash
check_distro(){
   if [[ -e /etc/redhat-release ]]
   then
     P="/bin/yum"
     #echo $P
   elif [[ -e /usr/bin/lsb_release ]]
   then
     DISTRO=`lsb_release -d | awk '{print $2}'`
     P="/usr/bin/apt-get"
     #echo $P
   fi
}
check_distro
