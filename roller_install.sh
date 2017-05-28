#!/usr/bin/env bash
#roller install script
ROLLER_GIT="http://git-wip-us.apache.org/repos/asf/roller.git"
GIT=`which git`
JAVA="/opt/java/jdk1.8.0_131/bin/java"
MVN=`which mvn`

get_install(){
  if [[ -e /bin/yum ]]
  then
     sudo yum -y install $1
  elif [[ -e /bin/apt-get ]]
  then
     sudo apt-get -y install $1
  fi
}

do_remove(){
  if [[ -e /bin/yum ]]
  then
     sudo yum -y remove $1
  elif [[ -e /bin/apt-get ]]
  then
     sudo apt-get -y remove --purge $1
  fi
}


#No maven?
maven_install(){
  if [[ ! $MVN ]]
  then
    get_install maven
  fi
}
     

git_install(){
  if [[ ! $GIT ]]
  then
   get_install git
  else
   echo "git already installed"
  fi
}

get_roller_mvn(){
  if [[ ! -d ./roller ]]
  then
   $GIT clone $ROLLER_GIT
  fi
  cd roller
  if [[ ! -e ./app/target/roller.war ]]
  then
     mvn clean install
  fi
}

do_test(){
  cd ./app;
  mvn jetty:run
}

ask_test(){
  echo "Do ya want to test roller with jetty run"
  read ANSWER
  if [[ $ANSWER=="y" ]]
  then
    do_test
  else
    echo "Bye"
  fi
}


install_oracle_java(){
if [[ ! $JAVA ]]
then
  sudo bash ./oracle_install.sh 8
  sudo mv /bin/java /bin/java.old
  sudo ln -s $JAVA /bin/java
fi
}


#Java from openjdk to oracle jdk 8
git_install
maven_install
install_oracle_java
get_roller_mvn
ask_test
