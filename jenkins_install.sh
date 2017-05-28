#!/usr/bin/env bash

java_check(){
  which java
  if [[ $? == "0" ]]
  then
     echo "java installed"
     java -version
  else
     echo "You must install java to run jenkins"
  fi
}

install_jenkins(){
  if [[ -e /usr/bin/apt ]]
  then
   wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
   echo "deb https://pkg.jenkins.io/debian-stable binary/" >> /etc/apt/sources.list
   sudo apt-get update -y
   sudo apt-get install jenkins -y
  elif [[ -e /bin/yum ]]
  then
   sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
   sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
   sudo yum -y install jenkins
   sudo systemctl enable jenkins.service
   sudo systemctl start jenkins.service

  fi
}

check_jenkins(){
  ps -ef | grep -i jenkins
}

java_check
install_jenkins
check_jenkins
