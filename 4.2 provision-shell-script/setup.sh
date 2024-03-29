#/bin/sh

# install necessary tolls

sudo yum install -y git vim gcc glibc-static telnet psmisc

# install docker

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

if [! $(getent group docker) ]; then
    sudo groupadd docker
else
    echo "docker user group alreay exists"
fi

sudo gpasswd -a $USER docker
sudo systemctl start docker

rm -rf get-docker.sh
