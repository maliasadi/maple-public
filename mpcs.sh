#!/bin/bash

profname=.profile
p4confname=.p4config
exp=export
YES=yes

# Hello,
echo Hi $USER,
echo "I am MaplePCSetup."
echo "On your Maplesoft Linux Workstation,"
echo "I can set up $profname, $p4confname, and sandbox."
echo
# Files and Directories
## You may need to change this part carefully

##### FIX the following 
mapleroot=$HOME/sbox/main
maplelib=$HOME/maple/lib

prof=$HOME/$profname
echo + Would you like to set up $profname? "[yes/no]"
read check1var

p4conf=$HOME/$p4confname
echo + Would you like to set up $p4confname? "[yes/no]"
read check2var

echo + Whould you like to set up your Maple sandbox? "[yes/no]"
read check4var

# Paths Update
if [ "$YES" == "$check1var" ]; then
	  echo + $profname will be created at \"$prof\"
	echo + Is this location correct? "[yes/no]"
	read check3var
	if [ "$YES" != "$check3var" ]; then
		echo + So, what is the correct path? "(like /home/$USER)"
		read prof
	fi
fi

if [ "$YES" == "$check2var" ]; then
	  echo + $p4confname will be created at \"$p4conf\"
        echo + Is this location correct? "[yes/no]"
        read check3var
        if [ "$YES" != "$check3var" ]; then
		echo + So, what is the correct path? "(like /home/$USER)"
		read p4conf
	fi

fi
echo


# Setup .profile
## export PS1="\h \w \$ "
## export MAPLE_ROOT=$HOME/sbox/main
## export MAPLELIB=$HOME/maple/lib
## export PATH=$MAPLE_ROOT/bin:$PATH
## export P4CONFIG=.p4config

echo_prof () {
    if [ ! -f "$mapleroot" ]; then 
        mkdir -p  $mapleroot
    fi
    touch $prof
		echo $exp 'PS1="\h \w \$ "' >> $prof
		echo "$exp MAPLE_ROOT=$mapleroot" >> $prof
    echo "$exp MAPLELIB=$maplelib" >> $prof
    echo "$exp PATH=$mapleroot/bin:\$PATH" >> $prof
    echo "$exp P4CONFIG=$p4confname" >> $prof
    echo "+ $prof is successfully created!"
    echo 
}

if [ "$YES" == "$check1var" ]; then
	if [ -f "$prof" ]; then	
		echo + $prof already exists!
    echo + I will replace it with a new file. Continue? "[yes/no]"?
    read check3var
    if [ "$YES" == "$check3var" ]; then
        rm $prof
        echo_prof
    fi
	else
      echo_prof
	fi
fi

# Setup .p4config
## P4CLIENT=username_sbox_main
## P4PORT=perforce:1616
## P4PASSWD=your perforce password

echo_p4conf () {
    echo + To set up $p4confname, I need a few information:
    echo + What is your perforce username?
    read p4client
    echo + What is your perforce password?
    read p4passwd
    touch $p4conf
    echo P4CLIENT="$p4client"_sbox_main >> $p4conf
    echo "P4PORT=perforce:1616" >> $p4conf
    echo "P4PASSWD=$p4passwd" >> $p4conf
    echo "+ $p4confname is successfully created!"
    echo 
}

if [ "$YES" == "$check2var" ]; then
	  if [ -f "$p4conf" ]; then	
		    echo + $p4conf already exists!
        echo + I will replace it with a new file. Continue? "[yes/no]"?
        read check3var
        if [ "$YES" == "$check3var" ]; then
            rm $p4conf
            echo_p4conf
        fi
	  else
        echo_p4conf
	  fi
fi

# Setup sandbox
if [ "$YES" == "$check4var" ]; then
    if [ ! -f "$mapleroot" ]; then 
        mkdir -p  $mapleroot
    fi
    echo + Is \"$p4client\" your perforce username? "[yes/no]"
    read check3var
    if [ "$YES" != "$check3var" ]; then
        echo + What is your perforce username?
        read p4client
    fi
    echo TODO!
    # cd $mapleroot && p4 client

    # echo + Would you like to sync?
    # read check3var
    # if [ "$YES" == "$check3var" ]; then
    #     cd $mapleroot && p4 sync
    # fi
fi

echo EOS
