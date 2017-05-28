#!/usr/bin/env bash
#unattended upgrades 
s(){
  if [[ $? == "0" ]]
  then
    echo success
  else
    echo failed
    exit 1
  fi
}
upgrade(){
sudo apt-get -y install unattended-upgrades
s 
sudo cp -fv 20auto-upgrades /etc/apt/apt.conf.d/
s
sudo cp -fv 50unattended-upgrades /etc/apt/apt.conf.d/
s
}

upgrade
