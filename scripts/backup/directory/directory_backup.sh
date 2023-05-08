#!/bin/bash
# ---
# This script will archive a directory.
# You do not need to stop the service.
# ---


# Setting variables
# ---
SERVICE_NAME="directory-backup"
SERVICE_DIR="<PATH/TO/LIVE/DIRECTORY>"  # Do NOT use /PATH
BACKUP_DIR="</PATH/TO/BACKUP/DIRECTORY>"
RETENTION=7


# Archiving directory
# ---
echo "Starting backup"

cd $BACKUP_DIR
tar --exclude=/syodo/cloudnet/temp/ -cpvzf $SERVICE_NAME-$(date +"%Y-%m-%d_%H-%M").tar.gz -C / $SERVICE_DIR


# Retention check & deletion
# ---
OLD_BACKUPS=$(ls -l $BACKUP_DIR/*.gz | wc -l)

if [ $OLD_BACKUPS -gt $RETENTION ]; then
        find $BACKUP_DIR -name "*.gz" -daystart -mtime +$RETENTION -delete
fi

echo "Finished backup"
