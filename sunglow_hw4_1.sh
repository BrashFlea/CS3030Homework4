#!/bin/bash - 
#===============================================================================
#
#          FILE: sunglow_hw1_1.sh
# 
#         USAGE: ./sunglow_hw1_1.sh 
# 
#   DESCRIPTION: 
# 
#        AUTHOR: Parker Jensen (), parker.jensen@aggiemail.usu.edu
#  ORGANIZATION: 
#       CREATED: 10/11/2016 12:31
#      REVISION:  ---
#===============================================================================

#set -o nounset        # Treat unset variables as an error

#set basename variable

me=`basename "$0"`

#create a help function
help() { echo "Usage: $me -y year(2015 or 2016) -e email -u user(optional) -p password(optional)"; exit 0;} 

#parse arguments
year=""
email=""
user=""
pass=""

#check for help
if [[ $1 == "--help" ]]
then
	help
fi

#getopts (arguments y e u p)
while getopts "y:e:u:p:" o;
do
	case "${o}" in 
		y)
			year=${OPTARG}
			;;
		e)
			email=${OPTARG}
			;;
		u)
			user=${OPTARG}
			;;
		p)
			pass=${OPTARG}
			;;
		*)
			help
			;;
	esac
done

#check for the necessary arguments
if [[ -z "$year" || -z "$email" ]]
then
	echo "Missing arguments"
	help
fi

#check for correct year
if [[ $year -ne 2016 && $year -ne 2015 ]]
then
	echo "Incorrect year"
	help
fi

#using the year grab the files
if [[ $year == 2015 ]]
then 
	wget icarus.cs.weber.edu/~hvalle/cs3030/MOCK_DATA_$year.tar.gz 
	year=$((year+1))
	wget icarus.cs.weber.edu/~hvalle/cs3030/MOCK_DATA_$year.tar.gz 
fi


if [[ $year == 2015 ]]
then 
	wget icarus.cs.weber.edu/~hvalle/cs3030/MOCK_DATA_$year.tar.gz 
	year=$((year-1))
	wget icarus.cs.weber.edu/~hvalle/cs3030/MOCK_DATA_$year.tar.gz 
fi

exit 0

