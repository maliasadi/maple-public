#!/bin/sh
#./disconnect-sshfs.sh

# location (local path):
LOCATION=
echo "+ Try to unmount $ADRS"

fusermount -u $LOCATION

