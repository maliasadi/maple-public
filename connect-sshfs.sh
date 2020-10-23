#!/bin/sh
# ./connect-sshfs.sh

# connect-sshfs.sh 
#	- Mount folders and files from username@server_address in a folder. 
#	- Set the 'LOCATION', 'USER', and 'SERVER' before using this script.

#################
# location (local path):
LOCATION=
# username:
USER=
# server address
SERVER=

echo "+ Try to mount in $LOCATION"
echo "+ From $USER@$SERVER"

MOUNTS=$(mount | grep "$LOCATION")
if [ ! -z "$MOUNTS" ] ; then
    echo "+ Found the following mounted entry:"
    echo $MOUNTS
    exit 1
fi

sshfs -o idmap=user $USER@$SERVER:/home/$USER $LOCATION
