#!/usr/bin/env bash
#Add
. ./usage.sh
SF(){
 if [[ $? == "0" ]]
 then
   echo "Download of $1 was successful"
 else
   echo "Download of $1 was failed"
 fi
}
if [[ $1 == 7 ]]
then
  wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u55-b13/jdk-7u55-linux-x64.tar.gz" -O jdk-7-linux-x64.tar.gz
  SF $1
elif [[ $1 == 8 ]]
then
  echo "getting 8 version of oracle java"
  wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz" -O jdk-8-linux-x64.tar.gz
  SF $1
fi

