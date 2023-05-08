#!/bin/bash
# ---
# This script will backup a all sql based databases in a container.
# The script will use mysqldump command to achive this.
# You do not need to shutdown the server to backup your db.
# ---


# Setting variables
# ---
CONTAINER_NAME="mariadb_example"  # Adivesed to set "container_name" variable in the Docker container
BACKUP_DIR="</PATH/TO/BACKUP/DIRECTORY>"
RETENTION=7

MYSQL_PWD=$(docker exec $CONTAINER_NAME env | grep MYSQL_ROOT_PASSWORD |cut -d"=" -f2)


# Checking for dependencies
# ---
echo "Backup for databases has started"

if [ ! -d $BACKUP_DIR ]; then
    mkdir -p $BACKUP_DIR
fi


# Database dump
# ---
docker exec $CONTAINER_NAME mysqldump --all-databases -u root --password=$MYSQL_PWD \
        | gzip > $BACKUP_DIR/$CONTAINER_NAME-$(date +"%Y-%m-%d_%H-%M").sql.gz


# Delete old files
# ---
OLD_BACKUPS=$(ls -l $BACKUP_DIR/*.gz | wc -l)

if [ $OLD_BACKUPS -gt $RETENTION ]; then
        find $BACKUP_DIR -name "*.gz" -daystart -mtime +$RETENTION -delete
fi


echo "Backup for databases was completed"
