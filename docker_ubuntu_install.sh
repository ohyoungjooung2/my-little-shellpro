#!/usr/bin/env bash
#remove installed
#sudo apt-get remove docker docker-engine


#repo add
apt-get install -y \
 apt-transport-https \
 ca-certificates \
 curl \
 software-properties-common

#Officla gpg key add
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

#Verify 
apt-key fingerprint 0EBFCD88

#Stable release setup
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"


#Install docker
#Second latest version of docker
VERSION="17.03.0~ce-0~ubuntu-xenial"
sudo apt-get update -y
sudo apt-get install docker-ce=$VERSION
