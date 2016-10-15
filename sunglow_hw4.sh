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
host="137.190.19.97"

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


if [[ $year == 2016 ]]
then 
	wget icarus.cs.weber.edu/~hvalle/cs3030/MOCK_DATA_$year.tar.gz 
	year=$((year-1))
	wget icarus.cs.weber.edu/~hvalle/cs3030/MOCK_DATA_$year.tar.gz 
fi

#Jonathan Mirabile
#step 4
`mkdir -p temp`
DATE=`date +%Y_%m_%d_%H:%M:%S`

echo "Unpacking Files"
`tar -xzf MOCK_DATA_2015.tar.gz -C temp`
`tar -xzf MOCK_DATA_2016.tar.gz -C temp`

echo "Switching Directories"
pushd temp

echo "" > "temp.txt"
echo "Processing Data"
#Awk script does a couple things to the data:
#0 cat the data in the directory based on number (1-10 at this point in time)
#1 print all records (pipe into awk)
#2 determine if the email field is null and replace it (pipe into awk)
#3 determine if the record is a female from canada and print the first name, last name and email.
#Note: this strips the headers in the process
#4 create a temp.txt file to hold data output
#5 move temp.txt to previous directory and rename to MOCK_DATA_FILTER_$DATE
for i in {1..10};
do
cat MOCK_DATA$i.csv |  
awk -F, '{if(NR>1)print $2 "," $3 "," $4 "," $5 "," $6}' | 
awk -F, '{OFS = FS}{if(length($3) == 0){$3="waldo@weber.edu"}print}' |
awk -F, '{if($4 == "Female" && $5 == "Canada"){print $1 "," $2 "," $3 >> "temp.txt"}}'
done
mv "temp.txt" ../MOCK_DATA_FILTER_$DATE

echo "Switching Directories"
popd

#Zip the files up
#Note: deletes original that was moved to directory
`zip -qm MOCK_DATA_FILTER_$DATE MOCK_DATA_FILTER_*`
echo "Your data will be located in MOCK_DATA_FILTER_$DATE.zip"
chmod 666  MOCK_DATA_FILTER_$DATE.zip
#Clean your mess
rm -rf temp

if [[ $user != "" && $pass != "" ]]
then
	echo "Putting the files in the home directory of $user"
	ftp -inv $host <<EOF
	quote USER $user
	quote PASS $pass
	cd ~/
	put MOCK_DATA_FILTER_$DATE.zip
	bye
EOF
else
	echo "Putting files in the anonymous directory"
	user="anonymous"
	pass="waldo@weber.edu"
	ftp -inv $host <<EOF
	quote USER $user
	quote PASS $pass
	put MOCK_DATA_FILTER_$DATE.zip
	bye
EOF
fi

if [[ $? != 0 ]]
then
	echo "The ftp failed."
	echo "Exiting with error."
	exit 1
else
	echo "The ftp was successfull."
fi

rm MOCK_DATA*

exit 0

