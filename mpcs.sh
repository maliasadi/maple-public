#!/bin/bash
# run ./mpcs.sh


profname=.profile
p4confname=.p4config
exp=export
YES=yes

# Hello, World!
echo Hi $USER,
echo "I am MaplePCSetup."
echo "On your Maplesoft Linux Workstation,"
echo "I can set up $profname, $p4confname, and (sync) sandbox."
echo

# Files and Directories
home=$HOME

mapleroot=$home/sbox/main
maplelib=$home/maple/lib

prof=$home/$profname
echo + Would you like to set up $profname? "[yes/no]"
read check1var

p4conf=$home/$p4confname
echo + Would you like to set up $p4confname\? "[yes/no]"
read check2var

echo + Would you like to set up your Maple sandbox? "[yes/no]"
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
        echo + I will replace it with a new file. Continue? "[yes/no]"
        read check3var
        if [ "$YES" == "$check3var" ]; then
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
        echo + I will replace it with a new file. Continue? "[yes/no]"
        read check3var
        if [ "$YES" == "$check3var" ]; then
            rm $p4conf
            echo_p4conf
        fi
	  else
        echo_p4conf
	  fi
fi

# Setup/sync sandbox
if [ "$YES" == "$check4var" ]; then
    if [ ! -f "$mapleroot" ]; then 
        mkdir -p  $mapleroot
    fi
    echo + Is \"$p4client\" your perforce username? "[yes/no]"
    read check3var
    if [ "$YES" != "$check3var" ]; then
	if [ -f "$p4conf" ]; then
	    rm $p4conf
	fi
    	echo_p4conf
    fi
    (cd $mapleroot; p4 sync)
fi

echo EOS
