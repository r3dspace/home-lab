#!/bin/bash
# ---
# Script will display selected QR-code in CLI.
# ---

# Root check
# ---
if [ $(id -u) -ne 0 ]
then
    echo "\n⚠️ \033[33mPlease run script as root!\033[m\n---\nThe spacestation script needs to be run with root user privileges.\n---"
    exit
fi

# Select and print QR-code
echo "Input Wireguard container name: "
read wg_container
echo "Input Wireguard peer name: "
read wg_peer

docker exec -it $wg_container /app/show-peer $wg_peer