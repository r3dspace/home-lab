#!/bin/bash
# -------------------------------------------------------- #
# As of this version this moduel only supports Ubuntus OS.
# Future support for Debian and other distros is coming.
# -------------------------------------------------------- #


# Global variables
# ---
Color_Off='\033[0m'       # Text Reset
BICyan='\033[1;96m'       # Bold Intensity Cyan
BIYellow='\033[1;33m'     # Bold Intensity Yellow


# Root check
# --- 
if [ $(id -u) -ne 0 ]
then
    echo "\n⚠️ ${Yellow}Please run script as root!${Color_Off}\n---\nThe spacestation script needs to be run with root user privileges.\n---"
    exit
fi


# APT update & upgrade of OS
# ---
echo "👾 APT update & upgrade of OS. This can take up to several minutes"
apt-get update > /dev/null
apt-get upgrade -y > /dev/null


# Check for needed dependencies
# ---
echo "🔍 Looking for dependencies"

if ! which curl > /dev/null
then
    echo "🤨 Was unable to locate 'curl'"
    echo "👾 Installing 'curl' now"
    apt install curl > /dev/null
    if which curl > /dev/null
    then
        echo "😃 Successful install of 'curl'"
    else
        echo "💢 Error installing 'curl'"
        exit
    fi
fi

if ! which update-ca-certificates > /dev/null
then
    echo "🤨 Was unable to locate 'ca-certificates'"
    echo "👾 Installing 'ca-certificates' now"
    apt install ca-certificates > /dev/null
    if which update-ca-certificates > /dev/null
    then
        echo "😃 Successful install of 'ca-certificates'"
    else
        echo "💢 Error installing 'ca-certificates'"
        exit
    fi
fi

if ! which gpg > /dev/null
then
    echo "🤨 Was unable to locate 'gnupg'"
    echo "👾 Installing 'gnupg' now"
    apt install gnupg > /dev/null
    if which gpg > /dev/null
    then
        echo "😃 Successful install of 'gnupg'"
    else
        echo "💢 Error installing 'gnupg'"
        exit
    fi
fi

if ! which lsb_release > /dev/null
then
    echo "🤨 Was unable to locate 'lsb-release'"
    echo "👾 Installing 'lsb-release' now"
    apt install lsb-release > /dev/null
    if which lsb_release > /dev/null
    then
        echo "😃 Successful install of 'lsb-release'"
    else
        echo "💢 Error installing 'lsb-release'"
        exit
    fi
fi

if ! which nala > /dev/null
then
    echo "🤨 Was unable to locate 'nala'"
    echo "🔄 Loading and setting Nala's repository, GPG key and setting source repo"
    
    # Setting repository, GPG key and setting source repo of Nala
    echo "deb https://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list > /dev/null
    wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
    echo "deb-src https://deb.volian.org/volian/ scar main" | sudo tee -a /etc/apt/sources.list.d/volian-archive-scar-unstable.list > /dev/null
    
    echo "🔄 Updateing local repos"
    sudo apt-get update > /dev/null

    # Installing Nala
    echo "👾 Installing 'nala' now"
    apt-get install nala -y > /dev/null

    if which nala > /dev/null
    then
        echo "😃 Successful install of 'nala'"
        echo "👾 Nala update, upgrade & clean OS"
        nala update -y
        nala upgrade -y
        
        echo "⚠️ ${BIYellow} Restarting host in 15 seconds! Run the script afterwards again to finish the install${Color_Off}"
        shutdown -r 15
        exit
    else
        echo "💢 Error installing 'nala'"
        exit
    fi
fi

echo "😃 Successfully found all dependencies"


# Adding Docker’s official Ubuntu GPG key
# ---
echo "➰ Adding Docker's official Ubuntu GPG key"

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg


# Setup of the Docker Ubuntu repository
# ---
echo "⚙️ Setup of the Docker Ubuntu repository"

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list


# Installing Docker engine and compose plugin
# ---
echo "👾 Installing 'docker-ce', 'docker-ce-cli', 'containerd.io' and 'docker-compose-plugin'"

nala install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin


# Basic check of Docker functionality
# ---
echo "\n👀 ${BICyan}Check if you see the output for the 'Docker' version and 'Docker Compose Plugin' version${Color_Off}"
sleep 3

docker version
docker compose version

echo "\n👀 ${BICyan}Check if you see the 'Hello-World' output from Docker${Color_Off}"
sleep 3

docker run hello-world

echo "\n👀 ${BICyan}If you saw the both outputs, means that the basic test was successful${Color_Off}"