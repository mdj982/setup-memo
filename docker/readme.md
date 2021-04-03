## Docker Settings

### Install
````bash
sudo apt remove docker docker-engine docker.io

sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - # get gpg key

sudo add-apt-repository "deb [arch=amd64] \
https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" # register repository

cat /etc/apt/sources.list | grep docker
# deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable
# # deb-src [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable

apt-cache madison docker-ce # confirm installable docker-ce versions
# docker-ce | 18.06.3~ce~3-0~ubuntu | https://download.docker.com/linux/ubuntu bionic/stable amd64 Packages


sudo apt install docker-ce=18.06.3~ce~3-0~ubuntu

docker --version
# Docker version 18.06.3-ce, build d7080c1
````

### Launch
```` bash
# Docker is running on Ubuntu in default
sudo systemctl start docker

systemctl status docker
# ● docker.service - Docker Application Container Engine ...

getent group | grep docker # confirm current user
sudo usermod -aG docker ${USERNAME} # ${USERNAME} can launch Docker
getent group | grep docker # confirm current user
# docker:x:999:${USERNAME}

exit

# relaunch terminal
docker info
docker run hello-world
# if still get permission denied, reboot and try again

````