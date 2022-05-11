#!/bin/bash

# Set color
Yellow='\033[0;33m'

# Timezone
timedatectl set-timezone 'Europe/Berlin'

# Direcoty setup
mkdir -p \
    /etc/scripts \
    /srv/docker \
    /srv/app \
    /srv/config/prometheus \
    /srv/config/templates \

# Install VirtIO Linux
apt-get install -y qemu-guest-agent

# OS up/upgrade
apt update -y && apt upgrade -y

# Preperation Docker
apt remove docker docker-engine docker.io containerd runc
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update -y

# Install dependencies
apt install -y \
    git \
    curl \
    net-tools \
    python3 \
    python3-pip \
    python3-venv \
    ca-certificates \
    gnupg \
    lsb-release \
    unattended-upgrades \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin \
    docker-compose

# Enable services
systemctl enable unattended-upgrades
systemctl start unattended-upgrades
systemctl enable docker
systemctl start docker

# Change unintended upgrades
cp ./data/50unattended-upgrades /etc/apt/apt.conf.d/
cp ./data/20auto-upgrades /etc/apt/apt.conf.d/

# Template copy
cp ./data/binarie.service /srv/config/templates/
cp ./data/java-archive.service /srv/config/templates/

# Cronjob setup
# cp ./data/cron <dir to cron root>

# Must shutdown after run. NO restart!
echo "${Yellow}"
echo "============================================================="
echo "You must run the following command after starting the host:"
echo "systemctl start qemu-guest-agent"
echo "============================================================="
echo ""
sudo shutdown 5