#!/bin/bash
#Machinaris installation on new Ubuntu 20.10 on Proxmox VM.
#Update the system to latest
#
sudo apt update -y 
sudo apt upgrade -y
# Install latest version of Docker
sudo apt-get install -y \
    apt-transport-https -y \
    ca-certificates -y \
    curl -y \
    gnupg -y\
    lsb-release -y
#
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
#
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
#Install latest docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
#Manage Docker as a non-root user
sudo groupadd docker
sudo usermod -aG docker $USER
#
# Prepare folder for machinaris docker compose 
mkdir ~/machinaris
cd ~/machinaris
echo "#Copy and Paste the docker compose data from https://www.machinaris.app/ here. When done press CTRL X & press enter">>docker-compose.yml
nano docker-compose.yml
echo "After reboot enter the command "docker-compose up" and press enter"
#
echo "Rebooting...when the system comes up run "docker-compose up"."
sleep 10
sudo reboot
