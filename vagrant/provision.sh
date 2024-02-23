#!/usr/bin/env bash
sudo apt-get update

# install git
sudo apt-get install git -y

# docker
sudo apt install docker.io -y
sudo apt install docker-compose -y

#reboot required for this to work
sudo usermod -aG docker vagrant

# force startup folder to /src folder in project
echo "cd /vagrant" >> /home/vagrant/.bashrc