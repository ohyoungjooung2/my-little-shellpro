#!/usr/bin/env bash
. ./install_subversion.sh
. ./roller_repo_create.sh

import_roller(){
 svn co https://svn.apache.org/repos/asf/roller/trunk /home/oyj/repos/roller_trunk
 svn import -m "import roller" /home/oyj/repos/roller_trunk file:///$DDIR/roller
}

start_svnserve(){
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
