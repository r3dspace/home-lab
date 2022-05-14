#!/bin/bash

# // Basic service setup
# Fetch all services (comming soon)
# Filter out critical services (comming soon)
# Stop non-critical services (comming soon)
# Check if service is stoped (comming soon)

# // Custom services (temporary)
service caddy stop > /dev/null 2>&1                 # Caddy service. Can be relplaced with other rev. proxys run on the host
service docker stop > /dev/null 2>&1                # Docker service
service wings stop > /dev/null 2>&1                 # Wings service for Pterodactyl
# service java-archive stop > /dev/null 2>&1        # Java-archive service
# service binarie stop > /dev/null 2>&1             # Binarie service

sleep 30

shutdown -r