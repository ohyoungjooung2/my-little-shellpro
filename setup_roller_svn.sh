#!/usr/bin/env bash
. ./install_subversion.sh
. ./roller_repo_create.sh
import_roller(){
 svn co https://svn.apache.org/repos/asf/roller/trunk roller_trunk
 svn import -m "first_import" ./roller_trunk file:///$DDIR/roller
}
import_roller

