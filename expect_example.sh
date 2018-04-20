#!/usr/bin/env expect
#Just execute uname -n of $serveraddress
set loginUser "vagrant"
set loginPassword "vagrant"
set serveraddress "localhost"

set timeout 20

spawn ssh -l $loginUser $serveraddress -p 22

expect "password:" {send "$loginPassword\r"}
expect "$ "
send "uname -n\r"
send "exit\r"
interact
