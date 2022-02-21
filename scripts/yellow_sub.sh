#! /bin/bash

# Script logo
yslogo () {
echo "
 __ __     _ _           _____     _   
|  |  |___| | |___ _ _ _|   __|_ _| |_ 
|_   _| -_| | | . | | | |__   | | | . |
  |_| |___|_|_|___|_____|_____|___|___|

A tool to navigate the docker CLI!
By Mr.Red"
}

# Main menu
ysmenu () {
read -p "
[1] Find container by name
[2] Find container IP by name
[3] Check .yml/.yaml formatation

Select a point: " menu
}

yslogo
ysmenu

# Heart of a script
if [ $menu -eq 1 ]; then
    read -p "Enter the name of the container: " var
    docker ps -f name=$var
elif [ $menu -eq 2 ]; then
    read -p "Enter the name or id of the container: " var
    ## Get container ID from container name
    docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' var
elif [ $menu -eq 3 ]; then
    ## Add sub-menu
elif [ $menu -eq 4 ]; then
    read -p "Enter the directory and name of the yaml file: " var
    ruby -ryaml -e "p YAML.load(STDIN.read)" < var
    ## Easy pass and error message
else
    echo "Input not recognized!"
fi