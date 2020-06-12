#!/bin/bash
# run ./mpcs.sh


PROFNAME=.profile
P4CONFNAME=.p4config
EXP=export
YES=yes

# Hello, World!
echo Hi $USER,
echo "I am MaplePCSetup."
echo "On your Maplesoft Linux Workstation,"
echo "I can set up $PROFNAME, $P4CONFNAME, and (sync) sandbox."
echo

# Files and Directories
home=$PWD

MAPLEROOT=$home/sbox/main
MAPLELIB=$home/maple/lib

prof=$home/$PROFNAME
echo + Would you like to set up $PROFNAME? "[yes/no]"
read CHECK1VAR

p4conf=$home/$P4CONFNAME
echo + Would you like to set up $P4CONFNAME\? "[yes/no]"
read CHECK2VAR

echo + Would you like to set up your Maple sandbox? "[yes/no]"
read check4var

# Paths Update
if [ "$YES" == "$CHECK1VAR" ]; then
	  echo + $PROFNAME will be created at \"$prof\"
	  echo + Is this location correct? "[yes/no]"
	  read CHECK3VAR
	  if [ "$YES" != "$CHECK3VAR" ]; then
		    echo + So, what is the correct path? "(e.g., /home/$USER/$PROFNAME)"
		    read prof
	  fi
fi

if [ "$YES" == "$CHECK2VAR" ]; then
	  echo + $P4CONFNAME will be created at \"$p4conf\"
        echo + Is this location correct? "[yes/no]"
        read CHECK3VAR
        if [ "$YES" != "$CHECK3VAR" ]; then
		echo + So, what is the correct path? "(e.g., /home/$USER/$P4CONFNAME)"
		read p4conf
	fi

fi
echo


# Setup .profile
echo_prof () {
    if [ ! -f "$MAPLEROOT" ]; then 
        mkdir -p  $MAPLEROOT
    fi
    touch $prof
		echo $EXP 'PS1="\h \w \$ "' >> $prof
		echo "$EXP MAPLE_ROOT=$MAPLEROOT" >> $prof
    echo "$EXP MAPLELIB=$MAPLELIB" >> $prof
    echo "$EXP PATH=$MAPLEROOT/bin:\$PATH" >> $prof
    echo "$EXP P4CONFIG=$P4CONFNAME" >> $prof
    echo "+ $prof is successfully created!"
    echo 
}

if [ "$YES" == "$CHECK1VAR" ]; then
	  if [ -f "$prof" ]; then
		    echo + $prof already exists!
        echo + I will replace it with a new file. Continue? "[yes/no]"
        read CHECK3VAR
        if [ "$YES" == "$CHECK3VAR" ]; then
            rm $prof
            echo_prof
        fi
	  else
        echo_prof
	  fi
	  (. $prof)
fi

# Setup .p4config
echo_p4conf () {
    echo + To set up $P4CONFNAME, I need a few information:
    echo + What is your perforce username?
    read p4client
    echo + What is your perforce password?
    read p4passwd
    touch $p4conf
    echo P4CLIENT="$p4client"_sbox_main >> $p4conf
    echo "P4PORT=perforce:1616" >> $p4conf
    echo "P4PASSWD=$p4passwd" >> $p4conf
    echo "+ $P4CONFNAME is successfully created!"
    echo 
}

if [ "$YES" == "$CHECK2VAR" ]; then
	  if [ -f "$p4conf" ]; then	
		    echo + $p4conf already exists!
        echo + I will replace it with a new file. Continue? "[yes/no]"
        read CHECK3VAR
        if [ "$YES" == "$CHECK3VAR" ]; then
            rm $p4conf
            echo_p4conf
        fi
	  else
        echo_p4conf
	  fi
fi

# Setup/sync sandbox
if [ "$YES" == "$check4var" ]; then
    if [ ! -f "$MAPLEROOT" ]; then
        mkdir -p  $MAPLEROOT
    fi
    echo + Is \"$p4client\" your perforce username? "[yes/no]"
    read CHECK3VAR
    if [ "$YES" != "$CHECK3VAR" ]; then
	if [ -f "$p4conf" ]; then
	    rm $p4conf
	fi
    	echo_p4conf
    fi
    (cd $MAPLEROOT; p4 sync)
fi

echo EOS
