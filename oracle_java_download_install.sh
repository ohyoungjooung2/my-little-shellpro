#!/usr/bin/env bash
NAME_JAVA="ORACLE_JAVA" 
INSTALLED_DIR="/opt/java"
ORACLE8="jdk-8-linux-x64.tar.gz"
ORACLE8_DIR="jdk1.8.0_101"
ORACLE7="jdk-7-linux-x64.tar.gz"
ORACLE7_DIR="jdk1.7.0_55"

INSTALL_DIR_CHECK(){
 if [[ ! -e $INSTALLED_DIR ]]
 then
    sudo mkdir $INSTALLED_DIR
 fi
}

#Usage
USAGE_ORACLE_JAVA(){
if [[ $1 == "" ]]
then
   echo $1
   echo "Usage) $0 7 for oracle 7, $0 8 for oracle 8 download"
   exit 1
fi
}


#Success check
SF(){
 if [[ $? == "0" ]]
 then
   echo "Download and install of  oracle java $1 was successful"
 else
   echo "Download and install of  oracle java $1 failed"
 fi
}

DOWNLOAD_ORACLE_JAVA(){
if [[ $1 == 7 ]]
then
  wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u55-b13/jdk-7u55-linux-x64.tar.gz" -O $ORACLE7 
  tar xvzf $ORACLE7
  sudo mv $ORACLE7_DIR $INSTALLED_DIR/
  sudo echo "export PATH=$PATH:$INSTALLED_DIR/$ORACLE7_DIR/bin" >> /etc/profile
  SF $1 
elif [[ $1 == 8 ]]
then
  echo "getting 8 version of oracle java"
  wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz" -O $ORACLE8
  tar xvzf $ORACLE8
  sudo mv $ORACLE8_DIR $INSTALLED_DIR/
  sudo echo "export PATH=$PATH:$INSTALLED_DIR/$ORACLE8_DIR/bin" >> /etc/profile
  SF $1
fi
}

INSTALL_DIR_CHECK
USAGE_ORACLE_JAVA $1
DOWNLOAD_ORACLE_JAVA $1

rm -f ./$ORACLE8 ./$ORACLE7
