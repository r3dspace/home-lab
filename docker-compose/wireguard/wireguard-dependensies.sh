#!/bin/bash
# ---
# Use this script when continuing to use the default
# vaules given in the docker-compose.yml file.
# Do NOT use the script if you change the default 
# values of the docker-compose.yml file!
# ---

# Root check
# ---
if [ $(id -u) -ne 0 ]
then
    echo "\n⚠️ \033[33mPlease run script as root!\033[m\n---\nThe spacestation script needs to be run with root user privileges.\n---"
    exit
fi

# General info of script
# ---
clear
echo "\033[36m
# Use this script when continuing to use the default
# vaules given in the docker-compose.yml file.
# Do NOT use the script if you change the default 
# values of the docker-compose.yml file!
\033[m"
while true
do
    input="N"
    read -r -p "Do you want to run the script? [y/N] " input
    case $input in
        [yY])
            break
            ;;
        [nN])
            clear
            exit
            ;;
        *)
            echo "❔ Invalid input. Please try again!"
            ;;
    esac
done


# Create needed directories for wireguard
# ---
if [ ! -d "/opt/docker/wireguard" ]
then
    mkdir -p /opt/docker/wireguard/wireguard
    if [ ! -d "/opt/docker/wireguard" ]
    then
        echo "💢 Error creating '/opt/docker/wireguard' directory!"
    else
        echo "😃 Successful creation directory!"
    fi
else
    echo "🤨 Directory '/opt/docker/wireguard' already exists!"
fi

# Copy docker-compose.yml
if [ ! -f /opt/docker/wireguard/docker-compose.yml ]
then
    cp ./docker-compose.yml /opt/docker/wireguard/
    chmod +x /opt/docker/wireguard/docker-compose.yml
    echo "😃 Copyed compose file to '/opt/docker/wireguard/docker-compose.yml'!"
else
    echo "💢 Error '/opt/docker/wireguard/docker-compose.yml' already exists. Please move it before rerunning the script!"
fi

# Copy show-qr-in-cli.sh
# ---
if [ ! -f /opt/docker/wireguard/show-qr-in-cli.sh ]
then
    cp ./tools/show-qr-in-cli.sh /opt/docker/wireguard/
    chmod +x /opt/docker/wireguard/show-qr-in-cli.sh
    echo "😃 Copyed and set permissions for '/opt/docker/wireguard/show-qr-in-cli.sh'!"
else
    echo "💢 Error '/opt/docker/wireguard/' already exists. Please move it before rerunning the script!"
fi

# Check for predefined docker network 'wireguard_network'
# ---
if ! docker network ls | grep wireguard_network > /dev/null
then
    docker network create \
        --driver=bridge \
        --subnet=172.155.0.0/16 \
        --ip-range=172.155.5.0/24 \
        --gateway=172.155.5.254 \
        wireguard_network
    if ! docker network ls | grep wireguard_network > /dev/null
    then
        echo "💢 Error creating docker network!"
    else
        echo "😃 Successful creation of docker network!"
    fi
else 
    echo "🤨 Docker network already exists!"
fi
