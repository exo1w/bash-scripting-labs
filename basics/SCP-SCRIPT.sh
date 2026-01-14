#!/bin/bash
#This script make an archive of specific directories and transfer the copies to a backup server


for dir in /etc /home /tmp
do
        [ ! -d "$dir" ] && echo "$dir does not exist" && continue

        ARCHIVE="$(basename "$dir")_backup_$(date +%F).tar"

        tar -cf "$ARCHIVE" "$dir"
        [ $? -eq 0 ] && echo "Tar archive for $dir created successfully"

        scp "$ARCHIVE" mohamed@10.0.11.190:/home/mohamed/backup
        # user on server = mohamed
        # 10.0.11.190 = server ip
        # make sure that user mohamed can do ssh to server
        [ $? -eq 0 ] && echo "Transfer done successfully. Archive will be deleted" && rm -f "$ARCHIVE"
done