#!/bin/bash
# 0 4 * * * ~/cronjobs/backup.sh > ~/cronjobs/backup.log 2>&1

--exclude="/*"

sshpass -f ~/.priv/storage rsync -av --recursive -e 'ssh -p23' --exclude="osrm/*/*.fileIndex" --exclude="R_library/*" --exclude="python_libs/*" /usr/local/share/public u261064@u261064.your-storagebox.de:/home/backups/*******/
sshpass -f ~/.priv/storage rsync -av --recursive -e 'ssh -p23' --exclude=".[!.]*" --exclude="node_modules/*" --exclude="software/*" --exclude="snap" /home/******* u261064@u261064.your-storagebox.de:/home/backups/*******/
sshpass -f ~/.priv/storage rsync -av --recursive -e 'ssh -p23' --exclude="media/*" /var/www/html u261064@u261064.your-storagebox.de:/home/backups/*******/
sshpass -f ~/.priv/storage rsync -av --recursive -e 'ssh -p23' /srv/shiny-server u261064@u261064.your-storagebox.de:/home/backups/*******/
