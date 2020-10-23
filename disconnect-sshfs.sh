#!/bin/sh
# ./disconnect-sshfs.sh

# disconnect-sshfs.sh
#	- Unmount!
#	- Set the 'LOCATION' before using this script.


# location (local path):
LOCATION=
echo "+ Try to unmount $ADRS"

fusermount -u $LOCATION

