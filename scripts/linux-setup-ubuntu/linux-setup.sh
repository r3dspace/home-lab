#!/bin/bash

# // Set color
# Setting color for bash.
Yellow='\033[0;33m'

# // Timezone
# Setting the host time zone. To see the list of all timezones use the command "timedatectl list-timezones".
timedatectl set-timezone 'Europe/Berlin'

# // OS up/upgrade
# Updating and upgrading the os to the latest version.
apt update -y && apt upgrade -y

# // Direcoty setup
# Creation of directorys for the script and applications. You can add others directorys with "/path \".
mkdir -p \
    /etc/scripts \
    /srv/docker \
    /srv/app \
    /srv/config/prometheus \
    /srv/config/templates \

# // Install VirtIO (OPTIONAL)
# Guest agent used by proxmox. Make sure that you have enabled the qemu setting in proxmox.
apt-get install -y qemu-guest-agent

# // Preperation Docker (OPTIONAL)
# Installation for ubuntu through https://docs.docker.com/engine/install/ubuntu/. Enable this if there are installation over apt under the "Install dependencies" title has issues.
: '
apt remove docker docker-engine docker.io containerd runc
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update -y
'

# // Install dependencies
# Installing most used dependencies/applications. If you do not need something just add a comment to it.
apt install -y \
    git \
    curl \
    wget \
    gnupg \
    net-tools \
    lsb-release \
    ca-certificates \
    unattended-upgrades \
    python3 \                     # Optional
    python3-pip \                 # Optional
    python3-venv \                # Optional
    qemu-kvm \                    # Optional. Enable "host" type on CPU when running proxmox VM.
    libvirt-daemon-system \       # Optional
    libvirt-clients \             # Optional
    bridge-utils \                # Optional
    # docker-ce \                 # Uncomment if use preperation docker
    # docker-ce-cli \             # Uncomment if use preperation docker
    # containerd.io \             # Uncomment if use preperation docker
    # docker-compose-plugin \     # Uncomment if use preperation docker
    docker.io \                   # Optional
    docker-compose                # Optional

# // Enable services
# Creating and starting services.
systemctl enable unattended-upgrades
systemctl start unattended-upgrades
systemctl enable docker
systemctl start docker

# // Change unintended-upgrades
# Set unintended-upgrades
cp ./data/50unattended-upgrades /etc/apt/apt.conf.d/
cp ./data/20auto-upgrades /etc/apt/apt.conf.d/

# // Template copy
# Copy templates into the "/srv/templates" directory.
cp ./data/binarie.service /srv/config/templates/
cp ./data/java-archive.service /srv/config/templates/

# // Script copy
# Copy scripts into the "/etc/scripts" directory.
cp ./scripts/launch_crashed_services.sh /etc/scripts/
cp ./scripts/safe_restart.sh /etc/scripts/

# // Cronjob setup
# Setting basic cronjobs for running scripts, which will be located under "/etc/scripts". 
# crontab -l > tmpcron      # Future feature
crontab ./data/cronjob

# // Info message for qemu-geust-agent
# If you use this script on a proxmox VM or use the qemu-guest-agent you must shutdown after installation. A restart will not work. Run the "systemctl start qemu-guest-agent" after starting the VM again.
echo "${Yellow}"
echo "============================================================="
echo "You must run the following command after starting the host:"
echo "systemctl start qemu-guest-agent"
echo "============================================================="
echo ""

sudo shutdown 2