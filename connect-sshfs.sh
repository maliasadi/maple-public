#!/bin/sh
# run ./connect-sshfs.sh


#################
# the location:
LOCATION=
# username:
USER=
# server address
SERVER=

echo "+ Try to mount in $LOCATION"
echo "+ From $USER@$SERVER"

MOUNTS=$(mount | grep "$LOCATION")
if [ ! -z "$MOUNTS" ] ; then
    echo + Found the following mounted entry:
    echo $MOUNTS
    exit 1
fi

sshfs -o idmap=user $USER@$SERVER:/home/$USER $LOCATION
