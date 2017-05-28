#!/usr/bin/env bash
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


