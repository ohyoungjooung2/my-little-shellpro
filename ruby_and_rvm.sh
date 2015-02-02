#!/usr/bin/env bash
# rvm install and ruby 2.0
sudo apt-get -y install curl nodejs
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -L https://get.rvm.io |bash -s stable
rvm requirements --autolibs=enable

cat /etc/issue | grep "Mint"

if [[ $? == "0" ]]
then
 source ~/.profile
else
 source $HOME/.bashrc

rvm install 2.0.0



