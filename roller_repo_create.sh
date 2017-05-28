#!/usr/bin/env bash
SA=`which svnadmin`
DDIR="$HOME/repos"
create_project_roller(){
$SA create $DDIR/roller
}
create_project_roller


