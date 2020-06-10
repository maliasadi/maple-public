#!/bin/sh
#./disconnect-sshfs.sh

# the location:
ADRS=
echo "+ Try to unmount $ADRS"

fusermount -u $ADRS

