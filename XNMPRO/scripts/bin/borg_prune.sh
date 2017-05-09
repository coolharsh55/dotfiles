#!/usr/bin/env bash
# Get backup disk information from user repo
NOW=$(date +"%Y-%m-%d %H:%M:%S,%3N")
echo "script started at $NOW"
# shellcheck disable=SC1091
source /home/harsh/.env
echo "Backup disk declared as ${BACKUPDISK}"
# Generate repository path from backup disk and hostname
REPOSITORY="/media/harsh/${BACKUPDISK}/backups/${HOSTNAME}"
echo "Repository at ${REPOSITORY}"
# check path is valid, abort if not
if [ ! -d $REPOSITORY ]; then
    echo ERROR: BACKUP FOLDER DOES NOT EXIST. DISK MAY NOT BE MOUNTED
    exit 1;
fi
# start backup
NOW=$(date +"%Y-%m-%d %H:%M:%S,%3N")
echo "starting borg backup prune at $NOW"
echo "NOTE: THIS IS A STUB SCRIPT, IT WILL NOT DELETE BACKUPS"
# set passphrase variable
# shellcheck source=/dev/null
source /home/harsh/.private/borg/${HOSTNAME}/passphrase
export BORG_PASSPHRASE=$PASSPHRASE
# create backup
TRIM=$(borg list $REPOSITORY | /home/harsh/bin/borg_prune.py)                                  
while read -r line;
do
    echo borg delete ${REPOSITORY}::$line
done <<< $TRIM

NOW=$(date +"%Y-%m-%d %H:%M:%S,%3N")
echo "finished prune at $NOW"
exit 0
