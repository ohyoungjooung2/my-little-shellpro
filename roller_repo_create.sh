#!/usr/bin/env bash
#Just for centos7 or redhat7 distros
SA=`which svnadmin`
DDIR="/var/svn"
if [[ ! -d /var/svn ]]
then
   mkdir $DDIR
fi
create_project_roller(){
 sudo $SA create $DDIR/roller
}
create_project_roller


