#!/usr/bin/env bash
#Docker should be installed first....
make_dir(){
	if [[ ! -d $1 ]]
        then 
		echo "$1 directory not exist, creating!"
	else

		echo "$1 directory exist, OK!!"
	fi
}
	
echo "Installign git-lab docker based as a nomal user(non-root)"
CONFIG_DIR=$HOME/gitlab_config
make_dir $CONFIG_DIR
LOG_DIR=$HOME/gitlab_log
make_dir $LOG_DIR
DATA_DIR=$HOME/gitlab_data
make_dir $DATA_DIR
HTTP_PORT=9090
HTTPS_PORT=9091
SSH_PORT=2222
sudo docker run --detach \
  --hostname gitlab.example.com \
  --publish $HTTPS_PORT:443 --publish $HTTP_PORT:80 --publish $SSH_PORT:22 \
  --name gitlab \
  --restart always \
  --volume $CONFIG_DIR:/etc/gitlab \
  --volume $LOG_DIR:/var/log/gitlab \
  --volume $DATA_DIR:/var/opt/gitlab \
  gitlab/gitlab-ce:latest
