#!/bin/bash

# // Caddy dir in host os.
# Create needed directories for caddy docker container.
mkdir -p /etc/caddy

# // Caddy files in host os.
# Copy needed files for caddy docker container
cp ./data/Caddyfile /etc/caddy/