#!/bin/bash - 
#===============================================================================
#
#          FILE: jonathan_mirabile_hw1.sh
# 
#         USAGE: ./jonathan_mirabile_hw1.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jonathan Mirabile (), jonathanmirabile@mail.weber.edu
#  ORGANIZATION: Weber State University
#       CREATED: 09/14/2016 17:52
#      REVISION:  ---
#===============================================================================

#set -o nounset                             
# Treat unset variables as an error

#Command line check - Help
Help()
{
	echo "--help Print this help message"
	echo "-w Print name three times"
	echo "With no arguments it provides a menu to test the system"
	exit 1
}

if [ "$1" = "--help" ]
then
	Help
fi

#Welcome
echo "Welcome to my first script for CS3030"
echo "My name is Jonathan Mirabile"
echo "you are running this script in $HOSTNAME"
echo ""

#Menu
echo "This script can do three things:"
echo "1. Check to see if the user is the root user"
echo "2. Check to see if the script is running on Linux OS"
echo "3. Check to see if the -w argument was given"
echo "What would you like to do? (1, 2, 3):"

#Read user input
read input

#1
if [ "$input" = 1 ]
then
#Privilege
	echo "Hello user. Your privilege level is:"
	case $UID in 
		0) echo "Root"
			;;
		*) echo "Normal"
			;;
	esac
fi


#2
if [ "$input" = 2 ]
then
#Output OS and check if Linux
	os=`uname -s`
	if [ "$os" = 'Linux' ]; then
		echo "The script is running on Linux"
	else
		echo "The script is not running on Linux"
	fi
fi


#3
if [ "$input" = 3 ]
then
	if [ "$1" = "-w" ]
	then
		if [ "$2" != "" ]
		then
			echo $2 $2 $2
		fi
	fi
fi

exit 0
