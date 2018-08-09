#!/usr/bin/env bash
#This script is for development only. Can adjust on production if you understad 100%. 
#Only Tested in ubuntu 18.04
VVERSION="vagrant_2.1.2_x86_64.deb"
DURL="https://releases.hashicorp.com/vagrant/2.1.2/vagrant_2.1.2_x86_64.deb"
CURL=$(which curl) 
#CHCKSUM="10c77b643b73dd3ad7a45a89d8ab95b58b79dc10e0cf6e760fe24abc436b2fdb" 
CHCKSUM="f614a60b258a856322f23d33a24201d26ab2555d047814fec403e834eb7d62b4" 
VCHECK=$(which vagrant)
PCHECK=$($VCHECK plugin list | grep vagrant-libvirt)

install_libvirt_plugin(){
  echo -e "\e[36m PLUGIN vagrant-libvirt pre requsities are being installed\e[0m"
  sudo apt install -y  ebtables dnsmasq libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev

  if [[ $PCHECK ]]
  then
    echo -e "\e[36m PLUGIN vagrant-libvirt already installed \e[0m"
  else
    echo -e "\e[33m PLUGIN vagrant-libvirt did not installed \e[0m"
    echo -e "\e[33m PLUGIN vagrant-libvirt  installing \e[0m"
     $VCHECK plugin install vagrant-libvirt
  fi
}

exist_check(){
  if [[ $VCHECK ]]
  then
     echo -e "\e[33m $($VCHECK -v) ALREADY INSTALLED \e[0m"
     install_libvirt_plugin
     exit 0
  else
     echo -e "\e[33m $VVERSION DID NOT INSATALLED \e[0m" 
  fi
}


download_vagrant(){
  if [[ ! $CURL ]]
  then
    apt -y install curl
  fi
  echo -e "\e[36m Downloading $VVERSION  \e[0m"
  $CURL -O $DURL
  if [[ $? == "0" ]]
  then
    echo -e "\e[36m Download ok ,Good \e[0m"
  else
    echo -e "\e[33m Download NOT ok ,Plz check\e[0m"
  fi
}


install_vagrant(){

  DCHECKSUM=$(/usr/bin/sha256sum $VVERSION | awk '{ print $1 }')
  if [[ $DCHECKSUM == $CHCKSUM ]]
  then
    echo -e "\e[36m Checksum ok ,do install \e[0m"
    sudo dpkg -i $VVERSION
  else
    echo -e "\e[36m Checksum not ok exit \e[0m"
    exit 3
  fi
}


exist_check
download_vagrant
install_vagrant
install_libvirt_plugin
