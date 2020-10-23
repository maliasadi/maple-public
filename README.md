# Maple (public-repo)

## MaplePCSetup
MPCS is a script to set up 'profile', 'perforce', and (sync) 'sandbox' on your Maple Linux workstation. 
- To use: 
	- Download mpcs.sh or clone the repository,
	- Make it executable, ($ chmod +x mpcs.sh)
	- Run! ($ ./mpcs.sh)

## Mount with SSHFS
- To use:
	- Download (dis)connect-sshfs.sh or clone the repository,
	- Make both executable, ($ chmod +x *connect-sshfs.sh)
	- (optional) move both to '/bin'
	- Set the 'LOCATION', 'USER', and 'SERVER' in (dis)connect-sshfs.sh 
	- Run! ($ ./(dis)connect-sshfs.sh)

- connect-sshfs.sh 
	- Mount folders and files from username@server_address in a folder. 
	- You need to set the 'USER', 'SERVER', and 'LOCATION' before using this script.
- disconnect-sshfs.sh
	- Unmount!


