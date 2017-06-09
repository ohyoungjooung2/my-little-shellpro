#!/usr/bin/env bash
. ./install_subversion.sh
. ./roller_repo_create.sh

import_roller(){
 #svn co https://svn.apache.org/repos/asf/roller/trunk /home/oyj/repos/roller_trunk
 cd $HOME/repos
 git clone http://git-wip-us.apache.org/repos/asf/roller.git

 svn import -m "import roller" $HOME/repos/roller file:///$DDIR/roller
}

start_svnserve(){
    #This is just for centos7.
    if [[ -e /bin/systemctl ]]
    then
     sudo systemctl enable svnserve
     sudo systemctl start svnserve
    elif [[ -e /sbin/service ]]
    then
     sudo service start svnserve
    fi
}

import_roller
start_svnserve
