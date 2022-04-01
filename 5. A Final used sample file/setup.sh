#/bin/sh

# install necessary tools at CentOS

sudo yum install -y git vim gcc glibc-static telnet psmisc

# install docker

curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh

# Add vagrant to docker groups, start docker service

sudo groupadd docker
sudo gpasswd -a vagrant docker
sudo systemctl start docker

# remove install docker script

rm -rf get-docker.sh
