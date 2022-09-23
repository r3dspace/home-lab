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


# Create needed directories for Caddyfile
# ---
if [ ! -d "/etc/caddy" ]
then
    mkdir -p /etc/caddy
    if [ ! -d "/etc/caddy" ]
    then
        echo "💢 Error creating '/etc/caddy' directory!"
    else
        echo "😃 Successful creation directory!"
    fi
else
    echo "🤨 Directory '/etc/caddy' already exists!"
fi

# Copy Caddyfile
# ---
if [ ! -f /etc/caddy/Caddyfile ]
then
    cp ./data/Caddyfile /etc/caddy/
else
    echo "💢 Error '/etc/caddy/Caddyfile' already exists. Please move it before rerunning the script!"
fi

# Check for predefined docker network 'caddy_proxy'
# ---
if ! docker network ls | grep caddy_proxy > /dev/null
then
    docker network create -d bridge caddy_proxy
    if ! docker network ls | grep caddy_proxy > /dev/null
    then
        echo "💢 Error creating docker network!"
    else
        echo "😃 Successful creation of docker network!"
    fi
else 
    echo "🤨 Docker network already exists!"
fi
