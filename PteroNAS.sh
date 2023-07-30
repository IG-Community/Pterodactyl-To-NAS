#!/bin/bash

#Normal Filesystem Backup
#You can Change the variable of "SERVERUSER"
SERVERUSER="username"

#DONT EDIT HERE!
d=`date +%d-%m-%Y`
h=$(hostname -s)

#Change to directory of the backup folder from Pterodactyl
cd /var/lib/pterodactyl/backups/

#Pack all created backups as one ZIP with server name and date.
zip -r "$h$d".zip *

#Move the created .ZIP file to the home backup folder of the NAS-Users
if  [[ ! -e "/home/$SERVERUSER/backups" ]]; then
            mkdir -p /home/$SERVERUSER/backups
fi
mv /var/lib/pterodactyl/backups/*.zip /home/$SERVERUSER/backups/

#Assign permissions to SERVERUSER for the download
chown -R $SERVERUSER /home/$SERVERUSER/backups
chmod 700 /home/$SERVERUSER/backups
echo "ZIP Done";
