#!/bin/bash

apt-get update
apt-install nmap
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-cache policy docker-ce
apt-get install -y docker-ce
touch index.html
echo Vizsga208 >index.html
touch Dockerfile
echo "FROM nginx:alpine" >Dockerfile
echo "MAINTAINER Gipsz Jakab" >>Dockerfile
echo "COPY . /usr/share/nginx/html" >>Dockerfile
echo "EXPOSE 80/tcp" >>Dockerfile
echo "EXPOSE 80/udp" >>Dockerfile
docker build -t ng .
docker run -d -p 80:80 --name "webszerver" ng

#sudo systemctl status docker        // fut-e a docker?
#sudo docker version                 // docker verzió megállapítása
#sudo docker images                  // milyen image-ek vannak a helyi gépen
