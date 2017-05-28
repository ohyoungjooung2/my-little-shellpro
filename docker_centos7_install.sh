#!/usr/bin/env bash
#Install docker for centos7 for the first time
docker_remove(){
  sudo yum remove docker \
                  docker-common \
                  container-selinux \
                  docker-selinux \
                  docker-engine
}

docker_install_ce_rp(){
   #Required packages
   sudo yum install -y yum-utils device-mapper-persistent-data lvm2
}

docker_add_repo(){
   #Repo
   sudo yum-config-manager  --add-repo  https://download.docker.com/linux/centos/docker-ce.repo
}

docker_install(){
   #Install!
   sudo yum makecache fast
   echo "Choose the docker version"
   sudo yum list docker-ce.x86_64  --showduplicates |sort -r
   read VERSION
   if [[ ! $VERSION ]]
   then
     echo "Plz input the version"
   else
     sudo yum install docker-ce-$VERSION
     sudo mkdir /etc/docker
     sudo cp ./daemon.json > /etc/docker/daemon.json 
   fi
   echo "Plz read https://docs.docker.com/engine/userguide/storagedriver/device-mapper-driver/#configure-direct-lvm-mode-for-production"
}

docker_remove
docker_install_ce_rp
docker_add_repo
docker_install
