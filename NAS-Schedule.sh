#!bin/sh

#You can Change the variable of ""
NASUSER=""
VOLUME=""
SSHKEY=""
SERVERIP=""
SSHPORT=""
SERVERUSER=""

#-------------------------------------------------------------

#DONT EDIT HERE!
echo "connect to external server..";
ssh -i /var/services/homes/"$NASUSER"/.ssh/"$SSHKEY" -p"$SSHPORT" "$SERVERUSER"@"$SERVERIP" "sudo ./scripts/backup.sh"
echo "waiting for zipping script on external server...";
wait


#Create a folder with the date of today
TODAY="$(date +'%d-%m-%Y')"
mkdir -p /"$VOLUME"/homes/"$NASUSER"/ServerBackups/"$TODAY"/


#Download the ZIP file via SCP (SFTP)
echo "Download Files...";
scp -i /var/services/homes/"$NASUSER"/.ssh/"$SSHKEY" -P"$SSHPORT" "$SERVERUSER"@"$SERVERIP":/home/"$SERVERUSER"/backups/*.zip /"$VOLUME"/homes/"$USERNAME"/ServerBackups/"$TODAY"/
echo "Download done";

#Waiting for download to finish
wait


#Delete ZIP file on server
echo "Remove temporary zip...";
ssh -i /var/services/homes/"$NASUSER"/.ssh/"$SSHKEY" -p"$SSHPORT" "$SERVERUSER"@"$SERVERIP" "rm backups/*.zip"


#Find and delete backups that are older than 30 days locally
echo "Remove files older than 30 days";
find /"$VOLUME"/homes/"$NASUSER"/ServerBackups/ -mtime +30 -delete
echo "BACKUP FINISH!";
