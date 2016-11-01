# CS3030Homework4
Jonathan Mirabile
Parker Jensen
Riley Curtis

\* denotes required

This script takes a year\*, email\*, username, and password then retrieves files from the WSU Icarus Server.

The script then processese the files using AWK, zips them up and uploads themto the users FTP server (if username and password are provided) otherwise uploads to the $host FTP server using an anonymous login.

Finally the script sends an email using the $email provided detailing if the script was successful or if it encountered an error.
